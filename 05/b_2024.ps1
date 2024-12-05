<#

#>

$strarray = Get-Content ina.txt
$answer = 0

$inputLen = $strarray.Length
$inputArray = New-Object int[] $inputLen

Function Test-Func {
    Param (
        [System.Collections.Specialized.OrderedDictionary] $playerOneDeck,
        [System.Collections.Specialized.OrderedDictionary] $playerTwoDeck
    )
    
}

$ruleMap = @{}
$mode = 0

foreach ($line in $strarray) {

    if ($line -eq "") {
        $mode = 1 
    } elseif ( $mode -eq 0 ) {
        [int[]] $pageRule = $line.Split("|")
        if( $ruleMap.ContainsKey($pageRule[0]) ) {
            $ruleMap[$pageRule[0]] += $pageRule[1]
        } else {
            $ruleMap.Add($pageRule[0],@($pageRule[1]))
        }
    } else {
        $correct = $true

        [int[]] $pageList = $line.Split(",")

        for ($i = 0; $i -lt $pageList.Count;$i++) {
            $afterList = $ruleMap[$pageList[$i]]

            for ($j = 0; $j -lt $afterList.Count;$j++) {
                $checkIndex = $pageList.IndexOf($afterList[$j])

                #Write-Host "$i $($pageList[$i]) : $checkIndex $($afterList[$j])"
                if ( ($checkIndex -ge 0) -and ($checkIndex -lt $i) ) {
                    $correct = $false
                    break
                }
            }

            if (!$correct) {
                break
            }
        }

        if ($correct) {
            $middleIndex = [Math]::floor($pageList.Count/2)
            $middleVal = $pageList[$middleIndex]
            #Write-Host "$($pageList.Count) $middleIndex $middleVal"
            $answer += $middleVal
        }

    }
    
}

Write-Host $answer