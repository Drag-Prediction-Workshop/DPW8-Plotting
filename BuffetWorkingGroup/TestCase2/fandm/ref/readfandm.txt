function dataset = readfandm(filename)
%readfandm  Read a DPW/AePW-style force-and-moment submittal .dat file.
%
%   dataset = readfandm(filename)
%
%   Parses the Tecplot-like ASCII format used by DPW-8 / AePW-4 submissions.
%   Lines beginning with '#' are treated as comments and skipped entirely.
%   All field names derived from the file (variable names, auxdata keys) are
%   stored in lower case.
%
%   Output structure fields:
%     .title      - (string)      Dataset title  (from TITLE = "...")
%     .variables  - (1xN cell)    Column names, lower case (from VARIABLES)
%     .auxdata    - (struct)      Dataset-level DATASETAUXDATA key/value pairs
%     .zones      - (1xZ struct)  One element per ZONE block, each containing:
%                     .title    - Zone title string  (from ZONE T="...")
%                     .auxdata  - Zone-level AUXDATA key/value pairs (struct)
%                     .data     - [nRows x nVars] numeric matrix
%
%   USAGE:
%     ds = readfandm('submission.dat');
%     disp(ds.title)
%     disp(ds.auxdata.solvername)
%     disp(ds.zones(1).data)
%     cl = ds.zones(2).data(:, strcmp(ds.variables, 'cl_avg'));

   % Set up
   dataset.title     = '';
   dataset.variables = {};
   dataset.auxdata   = struct();
   dataset.zones     = struct('title', {}, 'auxdata', {}, 'data', {});

   % Open file
   fid = fopen(filename, 'r');
   if fid == -1
      error('readfandm:fileNotFound', 'Cannot open file: %s', filename);
   end

   zoneindex = 0;    % index of the zone currently being built (0 = none yet)
   databuf = [];   % numeric row buffer for the current zone

   % Read
   while ~feof(fid)

      raw = fgetl(fid);
      if ~ischar(raw), break; end
      line = strtrim(raw);

      % Skip blank lines and comment lines
      if isempty(line) || line(1) == '#'
         continue;
      end

      % Figuring out what's happening
      if strncmpi(line, 'TITLE', 5)
         dataset.title = firstQuoted(line);

      elseif strncmpi(line, 'VARIABLES', 9)
         dataset.variables = lower(allQuoted(line));

      elseif strncmpi(line, 'DATASETAUXDATA', 14)
         [k, v] = parseKeyVal(line(15:end));
         if ~isempty(k)
            dataset.auxdata.(k) = v;
         end

      elseif strncmpi(line, 'ZONE', 4)
         if zoneindex > 0
            dataset.zones(zoneindex).data = databuf;
         end
         databuf                          = [];
         zoneindex                        = zoneindex + 1;
         dataset.zones(zoneindex).title   = firstQuoted(line);
         dataset.zones(zoneindex).auxdata = struct();
         dataset.zones(zoneindex).data    = [];

      elseif strncmpi(line, 'AUXDATA', 7)
         if zoneindex > 0
            [k, v] = parseKeyVal(line(8:end));
            if ~isempty(k)
               dataset.zones(zoneindex).auxdata.(k) = v;
            end
         end

      else
         % Is data
         row = sscanf(line, '%f')';
         if ~isempty(row)
            databuf = [databuf; row]; %#ok<AGROW>
         end
      end

   end % while

   % Flush data for the final zone
   if zoneindex > 0
      dataset.zones(zoneindex).data = databuf;
   end

   fclose(fid);

end % readfandm



%==========================================================================
%  Local helper functions
%==========================================================================

function str = firstQuoted(line)
%FIRSTQUOTED  Return content of the first double-quoted token on the line.
   tok = regexp(line, '"([^"]*)"', 'tokens', 'once');
   if isempty(tok)
      str = '';
   else
      str = strtrim(tok{1});
   end
end


function vals = allQuoted(line)
%ALLQUOTED  Return a cell array of ALL double-quoted tokens on the line.
   toks = regexp(line, '"([^"]*)"', 'tokens');
   if isempty(toks)
      vals = {};
   else
      vals = cellfun(@(t) strtrim(t{1}), toks, 'UniformOutput', false);
   end
end


function [key, val] = parseKeyVal(segment)
%PARSEKEYVAL  Parse '  SomeName  = "some value"' into a fieldname and string.
%
%   The key is lower-cased and sanitized with matlab.lang.makeValidName so it
%   can be used directly as a struct field  (e.g. 'Grid-File' -> 'grid_file').

   key = ''; val = '';
   parts = regexp(strtrim(segment), ...
                  '^(\S+)\s*=\s*"([^"]*)"', 'tokens', 'once');
   if numel(parts) == 2
      key = lower(matlab.lang.makeValidName(parts{1}));
      val = strtrim(parts{2});
   end
end
