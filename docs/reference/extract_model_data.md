# Extract Raw Variables from a Fitted Model

Extract Raw Variables from a Fitted Model

## Usage

``` r
extract_model_data(
  model,
  vars = NULL,
  include_response = TRUE,
  drop_na = TRUE,
  unique = FALSE
)
```

## Arguments

- model:

  A fitted model object (lm, glm, lmer, lmerTest, etc.).

- vars:

  Optional character vector specifying variables to extract. If NULL
  (default), returns all variables in the model frame.

- include_response:

  Logical. If TRUE (default), includes the response variable.

- drop_na:

  Logical. If TRUE (default), returns complete cases matching the exact
  data frame used in model fitting.

- unique:

  Logical. If TRUE, returns unique rows/combinations. Default is FALSE.

## Value

A data.frame containing raw variable values.

## Examples

``` r
fit <- lm(salary ~ rank + yrs.since.phd, data = carData::Salaries)
extract_model_data(fit)
#>     salary      rank yrs.since.phd
#> 1   139750      Prof            19
#> 2   173200      Prof            20
#> 3    79750  AsstProf             4
#> 4   115000      Prof            45
#> 5   141500      Prof            40
#> 6    97000 AssocProf             6
#> 7   175000      Prof            30
#> 8   147765      Prof            45
#> 9   119250      Prof            21
#> 10  129000      Prof            18
#> 11  119800 AssocProf            12
#> 12   79800  AsstProf             7
#> 13   77700  AsstProf             1
#> 14   78000  AsstProf             2
#> 15  104800      Prof            20
#> 16  117150      Prof            12
#> 17  101000      Prof            19
#> 18  103450      Prof            38
#> 19  124750      Prof            37
#> 20  137000      Prof            39
#> 21   89565      Prof            31
#> 22  102580      Prof            36
#> 23   93904      Prof            34
#> 24  113068      Prof            24
#> 25   74830 AssocProf            13
#> 26  106294      Prof            21
#> 27  134885      Prof            35
#> 28   82379  AsstProf             5
#> 29   77000  AsstProf            11
#> 30  118223      Prof            12
#> 31  132261      Prof            20
#> 32   79916  AsstProf             7
#> 33  117256      Prof            13
#> 34   80225  AsstProf             4
#> 35   80225  AsstProf             4
#> 36   77000  AsstProf             5
#> 37  155750      Prof            22
#> 38   86373  AsstProf             7
#> 39  125196      Prof            41
#> 40  100938 AssocProf             9
#> 41  146500      Prof            23
#> 42   93418 AssocProf            23
#> 43  101299      Prof            40
#> 44  231545      Prof            38
#> 45   94384      Prof            19
#> 46  114778      Prof            25
#> 47   98193      Prof            40
#> 48  151768      Prof            23
#> 49  140096      Prof            25
#> 50   70768  AsstProf             1
#> 51  126621      Prof            28
#> 52  108875      Prof            12
#> 53   74692  AsstProf            11
#> 54  106639      Prof            16
#> 55  103760 AssocProf            12
#> 56   83900 AssocProf            14
#> 57  117704      Prof            23
#> 58   90215 AssocProf             9
#> 59  100135 AssocProf            10
#> 60   75044  AsstProf             8
#> 61   90304 AssocProf             9
#> 62   75243  AsstProf             3
#> 63  109785      Prof            33
#> 64  103613 AssocProf            11
#> 65   68404  AsstProf             4
#> 66  100522 AssocProf             9
#> 67  101000      Prof            22
#> 68   99418      Prof            35
#> 69  111512      Prof            17
#> 70   91412      Prof            28
#> 71  126320      Prof            17
#> 72  146856      Prof            45
#> 73  100131      Prof            29
#> 74   92391      Prof            35
#> 75  113398      Prof            28
#> 76   73266  AsstProf             8
#> 77  150480      Prof            17
#> 78  193000      Prof            26
#> 79   86100  AsstProf             3
#> 80   84240  AsstProf             6
#> 81  150743      Prof            43
#> 82  135585      Prof            17
#> 83  144640      Prof            22
#> 84   88825  AsstProf             6
#> 85  122960      Prof            17
#> 86  132825      Prof            15
#> 87  152708      Prof            37
#> 88   88400  AsstProf             2
#> 89  172272      Prof            25
#> 90  107008 AssocProf             9
#> 91   97032  AsstProf            10
#> 92  105128 AssocProf            10
#> 93  105631 AssocProf            10
#> 94  166024      Prof            38
#> 95  123683      Prof            21
#> 96   84000  AsstProf             4
#> 97   95611 AssocProf            17
#> 98  129676      Prof            13
#> 99  102235      Prof            30
#> 100 106689      Prof            41
#> 101 133217      Prof            42
#> 102 126933      Prof            28
#> 103 153303      Prof            16
#> 104 127512      Prof            20
#> 105  83850 AssocProf            18
#> 106 113543      Prof            31
#> 107  82099 AssocProf            11
#> 108  82600 AssocProf            10
#> 109  81500 AssocProf            15
#> 110 131205      Prof            40
#> 111 112429      Prof            20
#> 112  82100 AssocProf            19
#> 113  72500  AsstProf             3
#> 114 104279      Prof            37
#> 115 105000      Prof            12
#> 116 120806      Prof            21
#> 117 148500      Prof            30
#> 118 117515      Prof            39
#> 119  72500  AsstProf             4
#> 120  73500  AsstProf             5
#> 121 115313      Prof            14
#> 122 124309      Prof            32
#> 123  97262      Prof            24
#> 124  62884 AssocProf            25
#> 125  96614      Prof            24
#> 126  78162      Prof            54
#> 127 155500      Prof            28
#> 128  72500  AsstProf             2
#> 129 113278      Prof            32
#> 130  73000  AsstProf             4
#> 131  83001 AssocProf            11
#> 132  76840      Prof            56
#> 133  77500 AssocProf            10
#> 134  72500  AsstProf             3
#> 135 168635      Prof            35
#> 136 136000      Prof            20
#> 137 108262      Prof            16
#> 138 105668      Prof            17
#> 139  73877 AssocProf            10
#> 140 152664      Prof            21
#> 141 100102 AssocProf            14
#> 142  81500 AssocProf            15
#> 143 106608      Prof            19
#> 144  89942  AsstProf             3
#> 145 112696      Prof            27
#> 146 119015      Prof            28
#> 147  92000  AsstProf             4
#> 148 156938      Prof            27
#> 149 144651      Prof            36
#> 150  95079  AsstProf             4
#> 151 128148      Prof            14
#> 152  92000  AsstProf             4
#> 153 111168      Prof            21
#> 154 103994 AssocProf            12
#> 155  92000  AsstProf             4
#> 156 118971      Prof            21
#> 157 113341 AssocProf            12
#> 158  88000  AsstProf             1
#> 159  95408 AssocProf             6
#> 160 137167      Prof            15
#> 161  89516  AsstProf             2
#> 162 176500      Prof            26
#> 163  98510 AssocProf            22
#> 164  89942  AsstProf             3
#> 165  88795  AsstProf             1
#> 166 105890      Prof            21
#> 167 167284      Prof            16
#> 168 130664      Prof            18
#> 169 101210 AssocProf             8
#> 170 181257      Prof            25
#> 171  91227  AsstProf             5
#> 172 151575      Prof            19
#> 173  93164      Prof            37
#> 174 134185      Prof            20
#> 175 105000 AssocProf            17
#> 176 111751      Prof            28
#> 177  95436 AssocProf            10
#> 178 100944 AssocProf            13
#> 179 147349      Prof            27
#> 180  92000  AsstProf             3
#> 181 142467      Prof            11
#> 182 141136      Prof            18
#> 183 100000 AssocProf             8
#> 184 150000      Prof            26
#> 185 101000      Prof            23
#> 186 134000      Prof            33
#> 187 103750 AssocProf            13
#> 188 107500      Prof            18
#> 189 106300 AssocProf            28
#> 190 153750      Prof            25
#> 191 180000      Prof            22
#> 192 133700      Prof            43
#> 193 122100      Prof            19
#> 194  86250 AssocProf            19
#> 195  90000 AssocProf            48
#> 196 113600 AssocProf             9
#> 197  92700  AsstProf             4
#> 198  92000  AsstProf             4
#> 199 189409      Prof            34
#> 200 114500      Prof            38
#> 201  92700  AsstProf             4
#> 202 119700      Prof            40
#> 203 160400      Prof            28
#> 204 152500      Prof            17
#> 205 165000      Prof            19
#> 206  96545      Prof            21
#> 207 162200      Prof            35
#> 208 120000      Prof            18
#> 209  91300  AsstProf             7
#> 210 163200      Prof            20
#> 211  91000  AsstProf             4
#> 212 111350      Prof            39
#> 213 128400      Prof            15
#> 214 126200      Prof            26
#> 215 118700 AssocProf            11
#> 216 145350      Prof            16
#> 217 146000      Prof            15
#> 218 105350 AssocProf            29
#> 219 109650 AssocProf            14
#> 220 119500      Prof            13
#> 221 170000      Prof            21
#> 222 145200      Prof            23
#> 223 107150 AssocProf            13
#> 224 129600      Prof            34
#> 225  87800      Prof            38
#> 226 122400      Prof            20
#> 227  63900  AsstProf             3
#> 228  70000 AssocProf             9
#> 229  88175      Prof            16
#> 230 133900      Prof            39
#> 231  91000      Prof            29
#> 232  73300 AssocProf            26
#> 233 148750      Prof            38
#> 234 117555      Prof            36
#> 235  69700  AsstProf             8
#> 236  81700      Prof            28
#> 237 114000      Prof            25
#> 238  63100  AsstProf             7
#> 239  77202      Prof            46
#> 240  96200      Prof            19
#> 241  69200  AsstProf             5
#> 242 122875      Prof            31
#> 243 102600      Prof            38
#> 244 108200      Prof            23
#> 245  84273      Prof            19
#> 246  90450      Prof            17
#> 247  91100      Prof            30
#> 248 101100      Prof            21
#> 249 128800      Prof            28
#> 250 204000      Prof            29
#> 251 109000      Prof            39
#> 252 102000      Prof            20
#> 253 132000      Prof            31
#> 254  77500  AsstProf             4
#> 255 116450      Prof            28
#> 256  83000 AssocProf            12
#> 257 140300      Prof            22
#> 258  74000 AssocProf            30
#> 259  73800  AsstProf             9
#> 260  92550      Prof            32
#> 261  88600 AssocProf            41
#> 262 107550      Prof            45
#> 263 121200      Prof            31
#> 264 126000      Prof            31
#> 265  99000      Prof            37
#> 266 134800      Prof            36
#> 267 143940      Prof            43
#> 268 104350      Prof            14
#> 269  89650      Prof            47
#> 270 103700      Prof            13
#> 271 143250      Prof            42
#> 272 194800      Prof            42
#> 273  73000  AsstProf             4
#> 274  74000  AsstProf             8
#> 275  78500  AsstProf             8
#> 276  93000      Prof            12
#> 277 107200      Prof            52
#> 278 163200      Prof            31
#> 279 107100      Prof            24
#> 280 100600      Prof            46
#> 281 136500      Prof            39
#> 282 103600      Prof            37
#> 283  57800      Prof            51
#> 284 155865      Prof            45
#> 285  88650 AssocProf             8
#> 286  81800 AssocProf            49
#> 287 115800      Prof            28
#> 288  85000  AsstProf             2
#> 289 150500      Prof            29
#> 290  74000  AsstProf             8
#> 291 174500      Prof            33
#> 292 168500      Prof            32
#> 293 183800      Prof            39
#> 294 104800 AssocProf            11
#> 295 107300      Prof            19
#> 296  97150      Prof            40
#> 297 126300      Prof            18
#> 298 148800      Prof            17
#> 299  72300      Prof            49
#> 300  70700 AssocProf            45
#> 301  88600      Prof            39
#> 302 127100      Prof            27
#> 303 170500      Prof            28
#> 304 105260      Prof            14
#> 305 144050      Prof            46
#> 306 111350      Prof            33
#> 307  74500  AsstProf             7
#> 308 122500      Prof            31
#> 309  74000  AsstProf             5
#> 310 166800      Prof            22
#> 311  92050      Prof            20
#> 312 108100      Prof            14
#> 313  94350      Prof            29
#> 314 100351      Prof            35
#> 315 146800      Prof            22
#> 316  84716  AsstProf             6
#> 317  71065 AssocProf            12
#> 318  67559      Prof            46
#> 319 134550      Prof            16
#> 320 135027      Prof            16
#> 321 104428      Prof            24
#> 322  95642 AssocProf             9
#> 323 126431 AssocProf            13
#> 324 161101      Prof            24
#> 325 162221      Prof            30
#> 326  84500  AsstProf             8
#> 327 124714      Prof            23
#> 328 151650      Prof            37
#> 329  99247 AssocProf            10
#> 330 134778      Prof            23
#> 331 192253      Prof            49
#> 332 116518      Prof            20
#> 333 105450      Prof            18
#> 334 145098      Prof            33
#> 335 104542 AssocProf            19
#> 336 151445      Prof            36
#> 337  98053      Prof            35
#> 338 145000      Prof            13
#> 339 128464      Prof            32
#> 340 137317      Prof            37
#> 341 106231      Prof            13
#> 342 124312      Prof            17
#> 343 114596      Prof            38
#> 344 162150      Prof            31
#> 345 150376      Prof            32
#> 346 107986      Prof            15
#> 347 142023      Prof            41
#> 348 128250      Prof            39
#> 349  80139  AsstProf             4
#> 350 144309      Prof            27
#> 351 186960      Prof            56
#> 352  93519      Prof            38
#> 353 142500      Prof            26
#> 354 138000      Prof            22
#> 355  83600  AsstProf             8
#> 356 145028      Prof            25
#> 357  88709      Prof            49
#> 358 107309      Prof            39
#> 359 109954      Prof            28
#> 360  78785  AsstProf            11
#> 361 121946      Prof            14
#> 362 109646      Prof            23
#> 363 138771      Prof            30
#> 364  81285 AssocProf            20
#> 365 205500      Prof            43
#> 366 101036      Prof            43
#> 367 115435      Prof            15
#> 368 108413 AssocProf            10
#> 369 131950      Prof            35
#> 370 134690      Prof            33
#> 371  78182 AssocProf            13
#> 372 110515      Prof            23
#> 373 109707      Prof            12
#> 374 136660      Prof            30
#> 375 103275      Prof            27
#> 376 103649      Prof            28
#> 377  74856  AsstProf             4
#> 378  77081  AsstProf             6
#> 379 150680      Prof            38
#> 380 104121 AssocProf            11
#> 381  75996  AsstProf             8
#> 382 172505      Prof            27
#> 383  86895 AssocProf             8
#> 384 105000      Prof            44
#> 385 125192      Prof            27
#> 386 114330      Prof            15
#> 387 139219      Prof            29
#> 388 109305      Prof            29
#> 389 119450      Prof            38
#> 390 186023      Prof            33
#> 391 166605      Prof            40
#> 392 151292      Prof            30
#> 393 103106      Prof            33
#> 394 150564      Prof            31
#> 395 101738      Prof            42
#> 396  95329      Prof            25
#> 397  81035  AsstProf             8
extract_model_data(fit, vars = c("rank", "yrs.since.phd"))
#>          rank yrs.since.phd
#> 1        Prof            19
#> 2        Prof            20
#> 3    AsstProf             4
#> 4        Prof            45
#> 5        Prof            40
#> 6   AssocProf             6
#> 7        Prof            30
#> 8        Prof            45
#> 9        Prof            21
#> 10       Prof            18
#> 11  AssocProf            12
#> 12   AsstProf             7
#> 13   AsstProf             1
#> 14   AsstProf             2
#> 15       Prof            20
#> 16       Prof            12
#> 17       Prof            19
#> 18       Prof            38
#> 19       Prof            37
#> 20       Prof            39
#> 21       Prof            31
#> 22       Prof            36
#> 23       Prof            34
#> 24       Prof            24
#> 25  AssocProf            13
#> 26       Prof            21
#> 27       Prof            35
#> 28   AsstProf             5
#> 29   AsstProf            11
#> 30       Prof            12
#> 31       Prof            20
#> 32   AsstProf             7
#> 33       Prof            13
#> 34   AsstProf             4
#> 35   AsstProf             4
#> 36   AsstProf             5
#> 37       Prof            22
#> 38   AsstProf             7
#> 39       Prof            41
#> 40  AssocProf             9
#> 41       Prof            23
#> 42  AssocProf            23
#> 43       Prof            40
#> 44       Prof            38
#> 45       Prof            19
#> 46       Prof            25
#> 47       Prof            40
#> 48       Prof            23
#> 49       Prof            25
#> 50   AsstProf             1
#> 51       Prof            28
#> 52       Prof            12
#> 53   AsstProf            11
#> 54       Prof            16
#> 55  AssocProf            12
#> 56  AssocProf            14
#> 57       Prof            23
#> 58  AssocProf             9
#> 59  AssocProf            10
#> 60   AsstProf             8
#> 61  AssocProf             9
#> 62   AsstProf             3
#> 63       Prof            33
#> 64  AssocProf            11
#> 65   AsstProf             4
#> 66  AssocProf             9
#> 67       Prof            22
#> 68       Prof            35
#> 69       Prof            17
#> 70       Prof            28
#> 71       Prof            17
#> 72       Prof            45
#> 73       Prof            29
#> 74       Prof            35
#> 75       Prof            28
#> 76   AsstProf             8
#> 77       Prof            17
#> 78       Prof            26
#> 79   AsstProf             3
#> 80   AsstProf             6
#> 81       Prof            43
#> 82       Prof            17
#> 83       Prof            22
#> 84   AsstProf             6
#> 85       Prof            17
#> 86       Prof            15
#> 87       Prof            37
#> 88   AsstProf             2
#> 89       Prof            25
#> 90  AssocProf             9
#> 91   AsstProf            10
#> 92  AssocProf            10
#> 93  AssocProf            10
#> 94       Prof            38
#> 95       Prof            21
#> 96   AsstProf             4
#> 97  AssocProf            17
#> 98       Prof            13
#> 99       Prof            30
#> 100      Prof            41
#> 101      Prof            42
#> 102      Prof            28
#> 103      Prof            16
#> 104      Prof            20
#> 105 AssocProf            18
#> 106      Prof            31
#> 107 AssocProf            11
#> 108 AssocProf            10
#> 109 AssocProf            15
#> 110      Prof            40
#> 111      Prof            20
#> 112 AssocProf            19
#> 113  AsstProf             3
#> 114      Prof            37
#> 115      Prof            12
#> 116      Prof            21
#> 117      Prof            30
#> 118      Prof            39
#> 119  AsstProf             4
#> 120  AsstProf             5
#> 121      Prof            14
#> 122      Prof            32
#> 123      Prof            24
#> 124 AssocProf            25
#> 125      Prof            24
#> 126      Prof            54
#> 127      Prof            28
#> 128  AsstProf             2
#> 129      Prof            32
#> 130  AsstProf             4
#> 131 AssocProf            11
#> 132      Prof            56
#> 133 AssocProf            10
#> 134  AsstProf             3
#> 135      Prof            35
#> 136      Prof            20
#> 137      Prof            16
#> 138      Prof            17
#> 139 AssocProf            10
#> 140      Prof            21
#> 141 AssocProf            14
#> 142 AssocProf            15
#> 143      Prof            19
#> 144  AsstProf             3
#> 145      Prof            27
#> 146      Prof            28
#> 147  AsstProf             4
#> 148      Prof            27
#> 149      Prof            36
#> 150  AsstProf             4
#> 151      Prof            14
#> 152  AsstProf             4
#> 153      Prof            21
#> 154 AssocProf            12
#> 155  AsstProf             4
#> 156      Prof            21
#> 157 AssocProf            12
#> 158  AsstProf             1
#> 159 AssocProf             6
#> 160      Prof            15
#> 161  AsstProf             2
#> 162      Prof            26
#> 163 AssocProf            22
#> 164  AsstProf             3
#> 165  AsstProf             1
#> 166      Prof            21
#> 167      Prof            16
#> 168      Prof            18
#> 169 AssocProf             8
#> 170      Prof            25
#> 171  AsstProf             5
#> 172      Prof            19
#> 173      Prof            37
#> 174      Prof            20
#> 175 AssocProf            17
#> 176      Prof            28
#> 177 AssocProf            10
#> 178 AssocProf            13
#> 179      Prof            27
#> 180  AsstProf             3
#> 181      Prof            11
#> 182      Prof            18
#> 183 AssocProf             8
#> 184      Prof            26
#> 185      Prof            23
#> 186      Prof            33
#> 187 AssocProf            13
#> 188      Prof            18
#> 189 AssocProf            28
#> 190      Prof            25
#> 191      Prof            22
#> 192      Prof            43
#> 193      Prof            19
#> 194 AssocProf            19
#> 195 AssocProf            48
#> 196 AssocProf             9
#> 197  AsstProf             4
#> 198  AsstProf             4
#> 199      Prof            34
#> 200      Prof            38
#> 201  AsstProf             4
#> 202      Prof            40
#> 203      Prof            28
#> 204      Prof            17
#> 205      Prof            19
#> 206      Prof            21
#> 207      Prof            35
#> 208      Prof            18
#> 209  AsstProf             7
#> 210      Prof            20
#> 211  AsstProf             4
#> 212      Prof            39
#> 213      Prof            15
#> 214      Prof            26
#> 215 AssocProf            11
#> 216      Prof            16
#> 217      Prof            15
#> 218 AssocProf            29
#> 219 AssocProf            14
#> 220      Prof            13
#> 221      Prof            21
#> 222      Prof            23
#> 223 AssocProf            13
#> 224      Prof            34
#> 225      Prof            38
#> 226      Prof            20
#> 227  AsstProf             3
#> 228 AssocProf             9
#> 229      Prof            16
#> 230      Prof            39
#> 231      Prof            29
#> 232 AssocProf            26
#> 233      Prof            38
#> 234      Prof            36
#> 235  AsstProf             8
#> 236      Prof            28
#> 237      Prof            25
#> 238  AsstProf             7
#> 239      Prof            46
#> 240      Prof            19
#> 241  AsstProf             5
#> 242      Prof            31
#> 243      Prof            38
#> 244      Prof            23
#> 245      Prof            19
#> 246      Prof            17
#> 247      Prof            30
#> 248      Prof            21
#> 249      Prof            28
#> 250      Prof            29
#> 251      Prof            39
#> 252      Prof            20
#> 253      Prof            31
#> 254  AsstProf             4
#> 255      Prof            28
#> 256 AssocProf            12
#> 257      Prof            22
#> 258 AssocProf            30
#> 259  AsstProf             9
#> 260      Prof            32
#> 261 AssocProf            41
#> 262      Prof            45
#> 263      Prof            31
#> 264      Prof            31
#> 265      Prof            37
#> 266      Prof            36
#> 267      Prof            43
#> 268      Prof            14
#> 269      Prof            47
#> 270      Prof            13
#> 271      Prof            42
#> 272      Prof            42
#> 273  AsstProf             4
#> 274  AsstProf             8
#> 275  AsstProf             8
#> 276      Prof            12
#> 277      Prof            52
#> 278      Prof            31
#> 279      Prof            24
#> 280      Prof            46
#> 281      Prof            39
#> 282      Prof            37
#> 283      Prof            51
#> 284      Prof            45
#> 285 AssocProf             8
#> 286 AssocProf            49
#> 287      Prof            28
#> 288  AsstProf             2
#> 289      Prof            29
#> 290  AsstProf             8
#> 291      Prof            33
#> 292      Prof            32
#> 293      Prof            39
#> 294 AssocProf            11
#> 295      Prof            19
#> 296      Prof            40
#> 297      Prof            18
#> 298      Prof            17
#> 299      Prof            49
#> 300 AssocProf            45
#> 301      Prof            39
#> 302      Prof            27
#> 303      Prof            28
#> 304      Prof            14
#> 305      Prof            46
#> 306      Prof            33
#> 307  AsstProf             7
#> 308      Prof            31
#> 309  AsstProf             5
#> 310      Prof            22
#> 311      Prof            20
#> 312      Prof            14
#> 313      Prof            29
#> 314      Prof            35
#> 315      Prof            22
#> 316  AsstProf             6
#> 317 AssocProf            12
#> 318      Prof            46
#> 319      Prof            16
#> 320      Prof            16
#> 321      Prof            24
#> 322 AssocProf             9
#> 323 AssocProf            13
#> 324      Prof            24
#> 325      Prof            30
#> 326  AsstProf             8
#> 327      Prof            23
#> 328      Prof            37
#> 329 AssocProf            10
#> 330      Prof            23
#> 331      Prof            49
#> 332      Prof            20
#> 333      Prof            18
#> 334      Prof            33
#> 335 AssocProf            19
#> 336      Prof            36
#> 337      Prof            35
#> 338      Prof            13
#> 339      Prof            32
#> 340      Prof            37
#> 341      Prof            13
#> 342      Prof            17
#> 343      Prof            38
#> 344      Prof            31
#> 345      Prof            32
#> 346      Prof            15
#> 347      Prof            41
#> 348      Prof            39
#> 349  AsstProf             4
#> 350      Prof            27
#> 351      Prof            56
#> 352      Prof            38
#> 353      Prof            26
#> 354      Prof            22
#> 355  AsstProf             8
#> 356      Prof            25
#> 357      Prof            49
#> 358      Prof            39
#> 359      Prof            28
#> 360  AsstProf            11
#> 361      Prof            14
#> 362      Prof            23
#> 363      Prof            30
#> 364 AssocProf            20
#> 365      Prof            43
#> 366      Prof            43
#> 367      Prof            15
#> 368 AssocProf            10
#> 369      Prof            35
#> 370      Prof            33
#> 371 AssocProf            13
#> 372      Prof            23
#> 373      Prof            12
#> 374      Prof            30
#> 375      Prof            27
#> 376      Prof            28
#> 377  AsstProf             4
#> 378  AsstProf             6
#> 379      Prof            38
#> 380 AssocProf            11
#> 381  AsstProf             8
#> 382      Prof            27
#> 383 AssocProf             8
#> 384      Prof            44
#> 385      Prof            27
#> 386      Prof            15
#> 387      Prof            29
#> 388      Prof            29
#> 389      Prof            38
#> 390      Prof            33
#> 391      Prof            40
#> 392      Prof            30
#> 393      Prof            33
#> 394      Prof            31
#> 395      Prof            42
#> 396      Prof            25
#> 397  AsstProf             8
```
