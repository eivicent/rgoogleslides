# List valid Google Slides shape types

Returns a character vector of all shape type strings accepted by the
Google Slides API's `createShape` request. Pass any of these values as
the `shape_type` argument of
[`add_create_shape_request()`](https://eivicent.github.io/rgoogleslides/reference/add_create_shape_request.md).

## Usage

``` r
gs_shape_types()
```

## Value

A character vector of valid shape type strings.

## Examples

``` r
gs_shape_types()
#>   [1] "TEXT_BOX"                      "RECTANGLE"                    
#>   [3] "ROUND_RECTANGLE"               "ELLIPSE"                      
#>   [5] "ARC"                           "BENT_ARROW"                   
#>   [7] "BENT_UP_ARROW"                 "BEVEL"                        
#>   [9] "BLOCK_ARC"                     "BRACE_PAIR"                   
#>  [11] "BRACKET_PAIR"                  "CAN"                          
#>  [13] "CHEVRON"                       "CHORD"                        
#>  [15] "CLOUD"                         "CORNER"                       
#>  [17] "CUBE"                          "CURVED_DOWN_ARROW"            
#>  [19] "CURVED_LEFT_ARROW"             "CURVED_RIGHT_ARROW"           
#>  [21] "CURVED_UP_ARROW"               "DECAGON"                      
#>  [23] "DIAGONAL_STRIPE"               "DIAMOND"                      
#>  [25] "DODECAGON"                     "DONUT"                        
#>  [27] "DOUBLE_WAVE"                   "DOWN_ARROW"                   
#>  [29] "DOWN_ARROW_CALLOUT"            "FOLDED_CORNER"                
#>  [31] "FRAME"                         "HALF_FRAME"                   
#>  [33] "HEART"                         "HEPTAGON"                     
#>  [35] "HEXAGON"                       "HOME_PLATE"                   
#>  [37] "HORIZONTAL_SCROLL"             "IRREGULAR_SEAL_1"             
#>  [39] "IRREGULAR_SEAL_2"              "LEFT_ARROW"                   
#>  [41] "LEFT_ARROW_CALLOUT"            "LEFT_BRACE"                   
#>  [43] "LEFT_BRACKET"                  "LEFT_RIGHT_ARROW"             
#>  [45] "LEFT_RIGHT_ARROW_CALLOUT"      "LEFT_RIGHT_UP_ARROW"          
#>  [47] "LEFT_UP_ARROW"                 "LIGHTNING_BOLT"               
#>  [49] "MATH_DIVIDE"                   "MATH_EQUAL"                   
#>  [51] "MATH_MINUS"                    "MATH_MULTIPLY"                
#>  [53] "MATH_NOT_EQUAL"                "MATH_PLUS"                    
#>  [55] "MOON"                          "NO_SMOKING"                   
#>  [57] "NOTCHED_RIGHT_ARROW"           "OCTAGON"                      
#>  [59] "PARALLELOGRAM"                 "PENTAGON"                     
#>  [61] "PIE"                           "PLAQUE"                       
#>  [63] "PLUS"                          "QUAD_ARROW"                   
#>  [65] "QUAD_ARROW_CALLOUT"            "RIBBON"                       
#>  [67] "RIBBON_2"                      "RIGHT_ARROW"                  
#>  [69] "RIGHT_ARROW_CALLOUT"           "RIGHT_BRACE"                  
#>  [71] "RIGHT_BRACKET"                 "RIGHT_TRIANGLE"               
#>  [73] "ROUND_1_RECTANGLE"             "ROUND_2_DIAGONAL_RECTANGLE"   
#>  [75] "ROUND_2_SAME_RECTANGLE"        "SMILEY_FACE"                  
#>  [77] "SNIP_1_RECTANGLE"              "SNIP_2_DIAGONAL_RECTANGLE"    
#>  [79] "SNIP_2_SAME_RECTANGLE"         "SNIP_ROUND_RECTANGLE"         
#>  [81] "STAR_4"                        "STAR_5"                       
#>  [83] "STAR_6"                        "STAR_7"                       
#>  [85] "STAR_8"                        "STAR_10"                      
#>  [87] "STAR_12"                       "STAR_16"                      
#>  [89] "STAR_24"                       "STAR_32"                      
#>  [91] "STRIPED_RIGHT_ARROW"           "SUN"                          
#>  [93] "TRAPEZOID"                     "TRIANGLE"                     
#>  [95] "UP_ARROW"                      "UP_ARROW_CALLOUT"             
#>  [97] "UP_DOWN_ARROW"                 "UTURN_ARROW"                  
#>  [99] "VERTICAL_SCROLL"               "WAVE"                         
#> [101] "WEDGE_ELLIPSE_CALLOUT"         "WEDGE_RECTANGLE_CALLOUT"      
#> [103] "WEDGE_ROUND_RECTANGLE_CALLOUT" "FLOW_CHART_ALTERNATE_PROCESS" 
#> [105] "FLOW_CHART_COLLATE"            "FLOW_CHART_CONNECTOR"         
#> [107] "FLOW_CHART_DECISION"           "FLOW_CHART_DELAY"             
#> [109] "FLOW_CHART_DISPLAY"            "FLOW_CHART_DOCUMENT"          
#> [111] "FLOW_CHART_EXTRACT"            "FLOW_CHART_INPUT_OUTPUT"      
#> [113] "FLOW_CHART_INTERNAL_STORAGE"   "FLOW_CHART_MAGNETIC_DISK"     
#> [115] "FLOW_CHART_MAGNETIC_DRUM"      "FLOW_CHART_MAGNETIC_TAPE"     
#> [117] "FLOW_CHART_MANUAL_INPUT"       "FLOW_CHART_MANUAL_OPERATION"  
#> [119] "FLOW_CHART_MERGE"              "FLOW_CHART_MULTIDOCUMENT"     
#> [121] "FLOW_CHART_OFFLINE_STORAGE"    "FLOW_CHART_OFFPAGE_CONNECTOR" 
#> [123] "FLOW_CHART_ONLINE_STORAGE"     "FLOW_CHART_OR"                
#> [125] "FLOW_CHART_PREDEFINED_PROCESS" "FLOW_CHART_PREPARATION"       
#> [127] "FLOW_CHART_PROCESS"            "FLOW_CHART_PUNCHED_CARD"      
#> [129] "FLOW_CHART_PUNCHED_TAPE"       "FLOW_CHART_SORT"              
#> [131] "FLOW_CHART_SUMMING_JUNCTION"   "FLOW_CHART_TERMINATOR"        
#> [133] "ARROW_EAST"                    "ARROW_NORTH_EAST"             
#> [135] "ARROW_NORTH"                   "SPEECH"                       
#> [137] "STARBURST"                     "TEARDROP"                     
#> [139] "ELLIPSE_RIBBON"                "ELLIPSE_RIBBON_2"             
#> [141] "CLOUD_CALLOUT"                 "CUSTOM"                       
```
