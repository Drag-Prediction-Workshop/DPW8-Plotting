#!MC 1410

#####################################################################
### Do Not Alter
#####################################################################

# Temporal Scheme
$!VarSet |Rans| = '1-17, 18-34, 35-51, 52-68, 69-85, 86-101, 102-117, 118-133, 134-149, 150-165, 169-184, 233-239, 240-246, 247-253, 254-269, 270-285, 286-301, 344-359, 362-377, 378-393, 394-408, 409-427, 428-443, 444-459, 460-475, 476-494, 498-513, 514-529, 530-545, 546-561, 562-577, 594-609, 610-625, 626-641, 642-667, 668-673, 695-703, 704-712, 714-728, 729-743, 744-759, 760-765, 766-781, 782-797, 798-813, 814-829, 830-845, 846-861, 862-869, 870-878, 895-910'
$!VarSet |Urans| = '168, 185-200, 302-315, 316-329, 330-343, 360, 676-694, 713, 879-887, 888-894, 911-921'
$!VarSet |Hrles| = '166, 167, 201-216, 361'
$!VarSet |Wmles| = '495-497'
$!VarSet |Dhrl|  = '217-232'


# Turbulence Model
#$!VarSet |Sa| = '1-17, 18-34, 52-68, 69-85, 86-101, 102-117, 118-133, 134-149, 150-165, 166, 167, 168, 233-239, 240-246, 254-269, 270-285, 286-301, 302-315, 316-329, 330-343, 344-359, 360, 361, 362-377, 378-393, 394-408, 409-427, 498-513, 514-529, 530-545, 546-561, 562-577, 578-593, 594-609, 610-625, 626-641, 642-667, 668-673, 695-703, 704-712, 713, 714-728, 744-759, 760-765, 766-781, 782-797, 798-813, 814-829, 830-845, 846-861, 870-878, 888-894, 895-910, 911-921'

$!VarSet |Sa| = '18-34, 86-101, 134-149, 233-239, 254-269, 302-315, 362-377, 378-393, 394-408, 409-427, 498-513, 546-561, 562-577, 695-703, 704-712, 713, 714-728, 744-759, 760-765, 766-781, 782-797, 798-813, 814-829, 830-845, 870-878'
#$!VarSet |SaR| = '102-117, 270-285, 316-329'
#$!VarSet |SaC| = '888-894'
$!VarSet |SaRC| = '102-117, 270-285, 316-329,888-894'
#$!VarSet |SaQCR| = '118-133'
#$!VarSet |SaRQCR| = '240-246, 286-301, 330-343'
#$!VarSet |SaRCQCR| = '52-68, 69-85, 344-359, 360, 361, 895-910, 911-921'
$!VarSet |SaRCQCR| = '1-17, 52-68, 69-85, 118-133, 240-246, 286-301, 330-343, 344-359, 360, 361, 895-910, 911-921'
$!VarSet |Sacomp| = '514-529, 578-593, 594-609, 846-861'
$!VarSet |SaRCcomp| = '150-165, 168'
#$!VarSet |SaQCRcomp| = '530-545, 610-625, 626-641'
#$!VarSet |SaRCQCRcomp| = '642-667, 668-673'
$!VarSet |SaRCQCRcomp| = '530-545, 610-625, 626-641, 642-667, 668-673'
$!VarSet |Sst| = '35-51, 201-216, 247-253, 428-443, 444-459, 460-475, 476-494, 676-694, 729-743, 862-869, 879-887'
$!VarSet |Kw| = '169-184, 185-200, 217-232'
$!VarSet |Dynamic| = '495-497'


# Grid Level
$!VarSet |Grid1|  = '1, 18, 35, 52, 69, 86, 102, 118, 134, 150, 166, 167, 168, 169, 185, 201, 217, 233, 240, 247, 254, 270, 286, 302, 316, 330, 344, 360, 361, 362, 378, 394, 409, 428, 444, 460, 476, 498, 514, 530, 546, 562, 578, 594, 610, 626, 642, 658, 674, 683, 684, 695, 704, 714, 729, 744, 760, 766, 782, 798, 814, 830, 846, 862, 870, 879, 895'
$!VarSet |Grid2|  = '2, 19, 36, 53, 70, 87, 103, 119, 135, 151, 170, 186, 202, 218, 234, 241, 248, 255, 271, 287, 303, 317, 331, 345, 363, 379, 395, 410, 429, 445, 461, 477, 499, 515, 531, 547, 563, 579, 595, 611, 627, 643, 659, 675, 696, 705, 715, 730, 745, 761, 767, 783, 799, 815, 831, 847, 863, 871, 880, 896'
$!VarSet |Grid3|  = '3, 20, 37, 54, 71, 88, 104, 120, 136, 152, 171, 187, 203, 219, 235, 242, 249, 256, 272, 288, 304, 318, 332, 346, 364, 380, 396, 411, 430, 446, 462, 478, 500, 516, 532, 548, 564, 580, 596, 612, 628, 644, 660, 676, 697, 706, 716, 731, 746, 762, 768, 784, 800, 816, 832, 848, 864, 872, 881, 888, 897, 911'
$!VarSet |Grid4|  = '4, 21, 38, 55, 72, 89, 105, 121, 137, 153, 172, 188, 204, 220, 236, 243, 250, 257, 273, 289, 305, 319, 333, 347, 365, 381, 397, 412, 431, 447, 463, 479, 501, 517, 533, 549, 565, 581, 597, 613, 629, 645, 661, 677, 698, 707, 717, 732, 747, 769, 785, 801, 817, 833, 849, 873, 898'
$!VarSet |Grid5|  = '5, 22, 39, 56, 73, 90, 106, 122, 138, 154, 173, 189, 205, 221, 237, 244, 251, 258, 274, 290, 348, 366, 382, 398, 413, 432, 448, 464, 480, 502, 518, 534, 550, 566, 582, 598, 614, 630, 646, 662, 678, 713, 718, 733, 748, 770, 786, 802, 818, 834, 850, 899'
$!VarSet |Grid6|  = '6, 23, 40, 57, 74, 91, 107, 123, 139, 155, 174, 190, 206, 222, 238, 245, 252, 259, 275, 291, 349, 367, 383, 414, 433, 449, 465, 481, 503, 519, 535, 551, 567, 583, 599, 615, 631, 647, 663, 679, 749, 771, 787, 803, 819, 835, 851, 900'
$!VarSet |Grid7|  = '415, 482, 680'
$!VarSet |Grid8|  = '416, 483, 681'
$!VarSet |Grid9|  = '417, 484, 682'
$!VarSet |Grid10| = '683'
$!VarSet |Grid11| = '684'

# Grid type
$!VarSet |CadenceStructured| = '52-68, 134-149, 150-165, 233-239, 240-246, 247-253, 344-359, 362-377, 428-443, 760-765, 766-781, 862-869, 870-878, 879-887, 888-894'
$!VarSet |CadenceUnstructured| = '1-17, 18-34, 35-51, 86-101, 102-117, 118-133, 169-184, 185-200, 201-216, 217-232, 378-393, 444-459, 498-513, 514-529, 530-545, 546-561, 562-577, 578-593, 594-609, 610-625, 626-641, 642-667, 668-673, 695-703, 704-712, 713, 714-728, 729-743, 782-797, 798-813, 814-829, 830-845, 846-861, 895-910, 911-921'
$!VarSet |HeldenAero| = '69-85, 394-408, 460-475'
$!VarSet |Custom| = '166, 167, 168, 254-269, 270-285, 286-301, 302-315, 316-329, 330-343, 360, 361, 409-427, 476-494, 495-497, 676-694, 744-759'


# Alpha
$!VarSet |Alpha1p36| = '8, 25, 42, 59, 76, 92, 108, 124, 140, 156, 175, 191, 207, 223, 260, 276, 292, 306, 320, 334, 350, 368, 384, 399, 418, 434, 450, 466, 485, 504, 520, 536, 552, 568, 584, 600, 616, 632, 648, 664, 685, 699, 708, 719, 734, 750, 763, 772, 788, 804, 820, 836, 852, 865, 874, 901, 912'
$!VarSet |Alpha1p50| = '9, 26, 43, 60, 77, 93, 109, 125, 141, 157, 176, 192, 208, 224, 239, 246, 253, 261, 277, 293, 307, 321, 335, 351, 369, 385, 400, 419, 435, 451, 467, 486, 505, 521, 537, 553, 569, 585, 601, 617, 633, 649, 665, 686, 700, 709, 720, 735, 751, 764, 773, 789, 805, 821, 837, 853, 866, 875, 902, 913'
$!VarSet |Alpha2p50| = '10, 27, 44, 61, 78, 94, 110, 126, 142, 158, 177, 193, 209, 225, 262, 278, 294, 308, 322, 336, 352, 370, 386, 401, 420, 436, 452, 468, 487, 506, 522, 538, 554, 570, 586, 602, 618, 634, 650, 666, 687, 701, 710, 721, 736, 752, 765, 774, 790, 806, 822, 838, 854, 867, 876, 903, 914'
$!VarSet |Alpha3p00| = '11, 28, 45, 62, 79, 95, 111, 127, 143, 159, 178, 194, 210, 226, 263, 279, 295, 309, 323, 337, 353, 371, 387, 402, 421, 437, 453, 469, 488, 507, 523, 539, 555, 571, 587, 603, 619, 635, 651, 667, 688, 722, 737, 753, 775, 791, 807, 823, 839, 855, 868, 877, 904, 915'
$!VarSet |Alpha3p10| = '12, 29, 46, 63, 80, 96, 112, 128, 144, 160, 179, 195, 211, 227, 264, 280, 296, 310, 324, 338, 354, 372, 388, 403, 422, 438, 454, 470, 489, 508, 524, 540, 556, 572, 588, 604, 620, 636, 652, 668, 689, 703, 712, 723, 738, 754, 776, 792, 808, 824, 840, 856, 869, 878, 882, 889, 905, 916'
$!VarSet |Alpha3p25| = '13, 30, 47, 64, 81, 97, 113, 129, 145, 161, 180, 196, 212, 228, 265, 281, 297, 311, 325, 339, 355, 373, 389, 404, 423, 439, 455, 471, 490, 509, 525, 541, 557, 573, 589, 605, 621, 637, 653, 669, 690, 724, 739, 755, 777, 793, 809, 825, 841, 857, 883, 890, 906, 917'
$!VarSet |Alpha3p40| = '14, 31, 48, 65, 82, 98, 114, 130, 146, 162, 181, 197, 213, 229, 266, 282, 298, 312, 326, 340, 356, 374, 390, 405, 424, 440, 456, 472, 491, 510, 526, 542, 558, 574, 590, 606, 622, 638, 654, 670, 691, 725, 740, 756, 778, 794, 810, 826, 842, 858, 884, 891, 907, 918'
$!VarSet |Alpha3p50| = '15, 32, 49, 66, 83, 99, 115, 131, 147, 163, 182, 198, 214, 230, 267, 283, 299, 313, 327, 341, 357, 375, 391, 406, 425, 441, 457, 473, 492, 511, 527, 543, 559, 575, 591, 607, 623, 639, 655, 671, 692, 726, 741, 757, 779, 795, 811, 827, 843, 859, 885, 892, 908, 919'
$!VarSet |Alpha3p60| = '16, 33, 50, 67, 84, 100, 116, 132, 148, 164, 183, 199, 215, 231, 268, 284, 300, 314, 328, 342, 358, 376, 392, 407, 426, 442, 458, 474, 493, 512, 528, 544, 560, 576, 592, 608, 624, 640, 656, 672, 693, 727, 742, 758, 780, 796, 812, 828, 844, 860, 886, 893, 909, 920'
$!VarSet |Alpha3p90| = '17, 34, 51, 68, 85, 101, 117, 133, 149, 165, 184, 200, 216, 232, 269, 285, 301, 315, 329, 343, 359, 377, 393, 408, 427, 443, 459, 475, 494, 513, 529, 545, 561, 577, 593, 609, 625, 641, 657, 673, 694, 728, 743, 759, 781, 797, 813, 829, 845, 861, 887, 894, 910, 921'

#####################################################################
### For your reference, here are all of the options... change vlaues below "Display Customizations"
#####################################################################

#Lines{Color = Custom9  LineThickness=0.25}
#Lines{Color = Custom10 LineThickness=0.25}
#Lines{Color = Custom11 LineThickness=0.25}
#Lines{Color = Custom12 LineThickness=0.25}
#Lines{Color = Custom13 LineThickness=0.25}
#Lines{Color = Custom14 LineThickness=0.25}
#Lines{Color = Custom15 LineThickness=0.25}
#Lines{Color = Custom16 LineThickness=0.25}
#Lines{Color = Custom17 LineThickness=0.25}
#Lines{Color = Custom18 LineThickness=0.25}
#Lines{Color = Custom19 LineThickness=0.25}
#
#Symbols{Color = Custom9  FillMode = UseLineColor SymbolShape{GeomShape = Square  } Size = 1.75 }
#Symbols{Color = Custom10 FillMode = UseLineColor SymbolShape{GeomShape = Del     } Size = 1.75 }
#Symbols{Color = Custom11 FillMode = UseLineColor SymbolShape{GeomShape = Grad    } Size = 1.75 }
#Symbols{Color = Custom12 FillMode = UseLineColor SymbolShape{GeomShape = RTri    } Size = 1.75 }
#Symbols{Color = Custom13 FillMode = UseLineColor SymbolShape{GeomShape = LTri    } Size = 1.75 }
#Symbols{Color = Custom14 FillMode = UseLineColor SymbolShape{GeomShape = Diamond } Size = 1.75 }
#Symbols{Color = Custom15 FillMode = UseLineColor SymbolShape{GeomShape = Circle  } Size = 1.75 }
#Symbols{Color = Custom16 FillMode = UseLineColor SymbolShape{IsASCII = Yes ASCIIShape{UseBaseFont = No FontOverride = Greek ASCIIChar = '\a'}} Size = 1.75 }
#Symbols{Color = Custom17 FillMode = UseLineColor SymbolShape{IsASCII = Yes ASCIIShape{UseBaseFont = No FontOverride = Greek ASCIIChar = '\b'}} Size = 1.75 }
#Symbols{Color = Custom18 FillMode = UseLineColor SymbolShape{IsASCII = Yes ASCIIShape{UseBaseFont = No FontOverride = Greek ASCIIChar = '\c'}} Size = 1.75 }
#Symbols{Color = Custom19 FillMode = UseLineColor SymbolShape{IsASCII = Yes ASCIIShape{UseBaseFont = No FontOverride = Greek ASCIIChar = '\d'}} Size = 1.75 }



#####################################################################
### Display Customizations
#####################################################################

$!If 0 == 1
   # Temporal Scheme
   $!LineMap [|Rans|]      Lines{Color = Custom9  LineThickness=0.25}
   $!LineMap [|Urans|]     Lines{Color = Custom10 LineThickness=0.25}
   $!LineMap [|Hrles|]     Lines{Color = Custom11 LineThickness=0.25}
   $!LineMap [|Wmles|]     Lines{Color = Custom12 LineThickness=0.25}
   $!LineMap [|Dhrl|]      Lines{Color = Custom13 LineThickness=0.25}

   $!LineMap [|Rans|]      Symbols{Color = Custom9  FillMode = UseLineColor SymbolShape{GeomShape = Square  } Size = 1.75 }
   $!LineMap [|Urans|]     Symbols{Color = Custom10 FillMode = UseLineColor SymbolShape{GeomShape = Del     } Size = 1.75 }
   $!LineMap [|Hrles|]     Symbols{Color = Custom11 FillMode = UseLineColor SymbolShape{GeomShape = Grad    } Size = 1.75 }
   $!LineMap [|Wmles|]     Symbols{Color = Custom12 FillMode = UseLineColor SymbolShape{GeomShape = RTri    } Size = 1.75 }
   $!LineMap [|Dhrl|]      Symbols{Color = Custom13 FillMode = UseLineColor SymbolShape{GeomShape = LTri    } Size = 1.75 }

$!EndIf

# Turbulence Model
$!If 0 == 1
   $!LineMap [|Sa|]          Lines{Color = Custom9   LineThickness=0.25}
   $!LineMap [|SaRC|]        Lines{Color = Custom10  LineThickness=0.25}
   $!LineMap [|SaRCQCR|]     Lines{Color = Custom11  LineThickness=0.25}
   $!LineMap [|Sacomp|]      Lines{Color = Custom12  LineThickness=0.25}
   $!LineMap [|SaRCcomp|]    Lines{Color = Custom13  LineThickness=0.25}
   $!LineMap [|SaRCQCRcomp|] Lines{Color = Custom14  LineThickness=0.25}
   
   $!LineMap [|Sst|]         Lines{Color = Custom15 LineThickness=0.25}
   $!LineMap [|Kw|]          Lines{Color = Custom16 LineThickness=0.25}
   $!LineMap [|Dynamic|]     Lines{Color = Custom17 LineThickness=0.25}

   $!LineMap [|Sa|]          Symbols{Color = Custom9   FillMode = UseLineColor SymbolShape{GeomShape = Square  } Size = 1.75 }
   $!LineMap [|SaRC|]        Symbols{Color = Custom10  FillMode = UseLineColor SymbolShape{GeomShape = Square  } Size = 1.75 }
   $!LineMap [|SaRCQCR|]     Symbols{Color = Custom11  FillMode = UseLineColor SymbolShape{GeomShape = Square  } Size = 1.75 }
   $!LineMap [|Sacomp|]      Symbols{Color = Custom12  FillMode = UseLineColor SymbolShape{GeomShape = Square  } Size = 1.75 }
   $!LineMap [|SaRCcomp|]    Symbols{Color = Custom13  FillMode = UseLineColor SymbolShape{GeomShape = Square  } Size = 1.75 }
   $!LineMap [|SaRCQCRcomp|] Symbols{Color = Custom14  FillMode = UseLineColor SymbolShape{GeomShape = Square  } Size = 1.75 }

   $!LineMap [|Sst|]         Symbols{Color = Custom15  FillMode = UseLineColor SymbolShape{GeomShape = Del     } Size = 1.75 }
   $!LineMap [|Kw|]          Symbols{Color = Custom16  FillMode = UseLineColor SymbolShape{GeomShape = Grad    } Size = 1.75 }
   $!LineMap [|Dynamic|]     Symbols{Color = Custom17  FillMode = UseLineColor SymbolShape{GeomShape = RTri    } Size = 1.75 }

$!EndIf



# Grid Level
$!If 0 == 1
   $!LineMap [|Grid1|]     Lines{Color = Custom9  LineThickness=0.25}
   $!LineMap [|Grid2|]     Lines{Color = Custom10 LineThickness=0.25}
   $!LineMap [|Grid3|]     Lines{Color = Custom11 LineThickness=0.25}
   $!LineMap [|Grid4|]     Lines{Color = Custom12 LineThickness=0.25}
   $!LineMap [|Grid5|]     Lines{Color = Custom13 LineThickness=0.25}
   $!LineMap [|Grid6|]     Lines{Color = Custom14 LineThickness=0.25}
   $!LineMap [|Grid7|]     Lines{Color = Custom15 LineThickness=0.25}
   $!LineMap [|Grid8|]     Lines{Color = Custom16 LineThickness=0.25}
   $!LineMap [|Grid9|]     Lines{Color = Custom17 LineThickness=0.25}
   $!LineMap [|Grid10|]    Lines{Color = Custom18 LineThickness=0.25}
   $!LineMap [|Grid11|]    Lines{Color = Custom19 LineThickness=0.25}

   $!LineMap [|Grid1|]     Symbols{Color = Custom9  FillMode = UseLineColor SymbolShape{GeomShape = Square  } Size = 1.75 }
   $!LineMap [|Grid2|]     Symbols{Color = Custom10 FillMode = UseLineColor SymbolShape{GeomShape = Del     } Size = 1.75 }
   $!LineMap [|Grid3|]     Symbols{Color = Custom11 FillMode = UseLineColor SymbolShape{GeomShape = Grad    } Size = 1.75 }
   $!LineMap [|Grid4|]     Symbols{Color = Custom12 FillMode = UseLineColor SymbolShape{GeomShape = RTri    } Size = 1.75 }
   $!LineMap [|Grid5|]     Symbols{Color = Custom13 FillMode = UseLineColor SymbolShape{GeomShape = LTri    } Size = 1.75 }
   $!LineMap [|Grid6|]     Symbols{Color = Custom14 FillMode = UseLineColor SymbolShape{GeomShape = Diamond } Size = 1.75 }
   $!LineMap [|Grid7|]     Symbols{Color = Custom15 FillMode = UseLineColor SymbolShape{GeomShape = Circle  } Size = 1.75 }
   $!LineMap [|Grid8|]     Symbols{Color = Custom16 FillMode = UseLineColor SymbolShape{IsASCII = Yes ASCIIShape{UseBaseFont = No FontOverride = Greek ASCIIChar = '\a'}} Size = 1.75 }
   $!LineMap [|Grid9|]     Symbols{Color = Custom17 FillMode = UseLineColor SymbolShape{IsASCII = Yes ASCIIShape{UseBaseFont = No FontOverride = Greek ASCIIChar = '\b'}} Size = 1.75 }
   $!LineMap [|Grid10|]    Symbols{Color = Custom18 FillMode = UseLineColor SymbolShape{IsASCII = Yes ASCIIShape{UseBaseFont = No FontOverride = Greek ASCIIChar = '\c'}} Size = 1.75 }
   $!LineMap [|Grid11|]    Symbols{Color = Custom19 FillMode = UseLineColor SymbolShape{IsASCII = Yes ASCIIShape{UseBaseFont = No FontOverride = Greek ASCIIChar = '\d'}} Size = 1.75 }
$!EndIf

# Grid Type
$!If 1 == 1
   $!LineMap [|CadenceStructured|]   Lines{Color = Custom9  LineThickness=0.25}
   $!LineMap [|CadenceUnstructured|] Lines{Color = Custom10 LineThickness=0.25}
   $!LineMap [|HeldenAero|]          Lines{Color = Custom11 LineThickness=0.25}
   $!LineMap [|Custom|]              Lines{Color = Custom12 LineThickness=0.25}

   $!LineMap [|CadenceStructured|]   Symbols{Color = Custom9  FillMode = UseLineColor SymbolShape{GeomShape = Square  } Size = 1.75 }
   $!LineMap [|CadenceUnstructured|] Symbols{Color = Custom10 FillMode = UseLineColor SymbolShape{GeomShape = Square  } Size = 1.75 }
   $!LineMap [|HeldenAero|]          Symbols{Color = Custom11 FillMode = UseLineColor SymbolShape{GeomShape = Square  } Size = 1.75 }
   $!LineMap [|Custom|]              Symbols{Color = Custom12 FillMode = UseLineColor SymbolShape{GeomShape = Square  } Size = 1.75 }
$!EndIf

# Alpha
$!If 0 == 1
   $!LineMap [|Alpha1p36|] Lines{Color = Custom9  LineThickness=0.25}
   $!LineMap [|Alpha1p50|] Lines{Color = Custom10 LineThickness=0.25}
   $!LineMap [|Alpha2p50|] Lines{Color = Custom11 LineThickness=0.25}
   $!LineMap [|Alpha3p00|] Lines{Color = Custom12 LineThickness=0.25}
   $!LineMap [|Alpha3p10|] Lines{Color = Custom13 LineThickness=0.25}
   $!LineMap [|Alpha3p25|] Lines{Color = Custom14 LineThickness=0.25}
   $!LineMap [|Alpha3p40|] Lines{Color = Custom15 LineThickness=0.25}
   $!LineMap [|Alpha3p50|] Lines{Color = Custom16 LineThickness=0.25}
   $!LineMap [|Alpha3p60|] Lines{Color = Custom17 LineThickness=0.25}
   $!LineMap [|Alpha3p90|] Lines{Color = Custom18 LineThickness=0.25}

   $!LineMap [|Alpha1p36|] Symbols{Color = Custom9  FillMode = UseLineColor SymbolShape{GeomShape = Square  } Size = 1.75 }
   $!LineMap [|Alpha1p50|] Symbols{Color = Custom10 FillMode = UseLineColor SymbolShape{GeomShape = Del     } Size = 1.75 }
   $!LineMap [|Alpha2p50|] Symbols{Color = Custom11 FillMode = UseLineColor SymbolShape{GeomShape = Grad    } Size = 1.75 }
   $!LineMap [|Alpha3p00|] Symbols{Color = Custom12 FillMode = UseLineColor SymbolShape{GeomShape = RTri    } Size = 1.75 }
   $!LineMap [|Alpha3p10|] Symbols{Color = Custom13 FillMode = UseLineColor SymbolShape{GeomShape = LTri    } Size = 1.75 }
   $!LineMap [|Alpha3p25|] Symbols{Color = Custom14 FillMode = UseLineColor SymbolShape{GeomShape = Diamond } Size = 1.75 }
   $!LineMap [|Alpha3p40|] Symbols{Color = Custom15 FillMode = UseLineColor SymbolShape{GeomShape = Circle  } Size = 1.75 }
   $!LineMap [|Alpha3p50|] Symbols{Color = Custom16 FillMode = UseLineColor SymbolShape{IsASCII = Yes ASCIIShape{UseBaseFont = No FontOverride = Greek ASCIIChar = '\a'}} Size = 1.75 }
   $!LineMap [|Alpha3p60|] Symbols{Color = Custom17 FillMode = UseLineColor SymbolShape{IsASCII = Yes ASCIIShape{UseBaseFont = No FontOverride = Greek ASCIIChar = '\b'}} Size = 1.75 }
   $!LineMap [|Alpha3p90|] Symbols{Color = Custom18 FillMode = UseLineColor SymbolShape{IsASCII = Yes ASCIIShape{UseBaseFont = No FontOverride = Greek ASCIIChar = '\c'}} Size = 1.75 }

$!EndIf

########################################################################
### Activate Zones
########################################################################

# Examples
#           $!ActiveLineMaps  =  []
#           $!ActiveLineMaps  =  [1-5]
#           $!ActiveLineMaps  =  [|RANS|,|HRLES|]
# Or add
#           $!ActiveLineMaps += [|Rans|]



$!ActiveLineMaps  =  []
# Turning on zones
#$!ActiveLineMaps += [|Rans|]
#$!ActiveLineMaps += [|Urans|]
#$!ActiveLineMaps += [|Hrles|]
#$!ActiveLineMaps += [|Wmles|]
#$!ActiveLineMaps += [|Dhrl|]

#$!ActiveLineMaps += [|Sa|]
#$!ActiveLineMaps += [|SaRC|]
#$!ActiveLineMaps += [|SaRCQCR|]
#$!ActiveLineMaps += [|Sacomp|]
#$!ActiveLineMaps += [|SaRCcomp|]
#$!ActiveLineMaps += [|SaRCQCRcomp|]
#$!ActiveLineMaps += [|Sst|]
#$!ActiveLineMaps += [|Kw|]
#$!ActiveLineMaps += [|Dynamic|]

#$!ActiveLineMaps += [|Grid1|]
#$!ActiveLineMaps += [|Grid2|]
#$!ActiveLineMaps += [|Grid3|]
#$!ActiveLineMaps += [|Grid4|]
#$!ActiveLineMaps += [|Grid5|]
#$!ActiveLineMaps += [|Grid6|]
#$!ActiveLineMaps += [|Grid7|]
#$!ActiveLineMaps += [|Grid8|]
#$!ActiveLineMaps += [|Grid9|]
#$!ActiveLineMaps += [|Grid10|]
#$!ActiveLineMaps += [|Grid11|]

#$!ActiveLineMaps += [|CadenceStructured|]
#$!ActiveLineMaps += [|CadenceUnstructured|]
#$!ActiveLineMaps += [|HeldenAero|]
#$!ActiveLineMaps += [|Custom|]

#$!ActiveLineMaps += [|Alpha1p36|]
#$!ActiveLineMaps += [|Alpha1p50|]
#$!ActiveLineMaps += [|Alpha2p50|]
#$!ActiveLineMaps += [|Alpha3p00|]
#$!ActiveLineMaps += [|Alpha3p10|]
#$!ActiveLineMaps += [|Alpha3p25|]
#$!ActiveLineMaps += [|Alpha3p40|]
#$!ActiveLineMaps += [|Alpha3p50|]
#$!ActiveLineMaps += [|Alpha3p60|]
$!ActiveLineMaps += [|Alpha3p90|]



# Turning off zones
#$!ActiveLineMaps -= [|Rans|]
$!ActiveLineMaps -= [|Urans|]
$!ActiveLineMaps -= [|Hrles|]
$!ActiveLineMaps -= [|Wmles|]
$!ActiveLineMaps -= [|Dhrl|]

#$!ActiveLineMaps -= [|Sa|]
#$!ActiveLineMaps -= [|SaRC|]
#$!ActiveLineMaps -= [|SaRCQCR|]
#$!ActiveLineMaps -= [|Sacomp|]
#$!ActiveLineMaps -= [|SaRCcomp|]
#$!ActiveLineMaps -= [|SaRCQCRcomp|]
#$!ActiveLineMaps -= [|Sst|]
#$!ActiveLineMaps -= [|Kw|]
#$!ActiveLineMaps -= [|Dynamic|]

#$!ActiveLineMaps -= [|Grid1|]
#$!ActiveLineMaps -= [|Grid2|]
#$!ActiveLineMaps -= [|Grid3|]
#$!ActiveLineMaps -= [|Grid4|]
#$!ActiveLineMaps -= [|Grid5|]
#$!ActiveLineMaps -= [|Grid6|]
#$!ActiveLineMaps -= [|Grid7|]
#$!ActiveLineMaps -= [|Grid8|]
#$!ActiveLineMaps -= [|Grid9|]
#$!ActiveLineMaps -= [|Grid10|]
#$!ActiveLineMaps -= [|Grid11|]

#$!ActiveLineMaps -= [|CadenceStructured|]
#$!ActiveLineMaps -= [|CadenceUnstructured|]
#$!ActiveLineMaps -= [|HeldenAero|]
#$!ActiveLineMaps -= [|Custom|]

#$!ActiveLineMaps -= [|Alpha1p36|]
#$!ActiveLineMaps -= [|Alpha1p50|]
#$!ActiveLineMaps -= [|Alpha2p50|]
#$!ActiveLineMaps -= [|Alpha3p00|]
#$!ActiveLineMaps -= [|Alpha3p10|]
#$!ActiveLineMaps -= [|Alpha3p25|]
#$!ActiveLineMaps -= [|Alpha3p40|]
#$!ActiveLineMaps -= [|Alpha3p50|]
#$!ActiveLineMaps -= [|Alpha3p60|]
#$!ActiveLineMaps -= [|Alpha3p90|]
