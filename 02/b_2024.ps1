<#

#>

$strarray = Get-Content ina.txt
$answer = 0

$inputLen = $strarray.Length
$inputArray = New-Object int[] $inputLen

Function Check-Array {
    Param (
        [System.Collections.ArrayList] $inputArray
    )

    $lastChange = 0

    $lastNumIndex = $inputArray.Count - 1

    for ($i = 0; $i -lt $lastNumIndex;$i++) {
        $diff = $inputArray[$i] - $inputArray[$i + 1]

        #if current diff and last diff are pos and neg, don't count
        $checkSameDirection = $lastChange * $diff
        if ($checkSameDirection -lt 0) {
            #Write-Host "Direction : $inputArray"
            return $i
        } else {
            $lastChange = $diff
        }

        #if current diff is not 1, 2, or 3, don't count
        $diff = [Math]::Abs($diff)
        if ( ($diff -lt 1) -or ($diff -gt 3) ) {
            #Write-Host "Range : $inputArray"
            return $i
        }
    }

    return -1
}

foreach ($line in $strarray) {
    $numbers = [int[]] $line.Split(" ")

    $numbersList = New-Object System.Collections.ArrayList(,$numbers)

    $check = [int] (Check-Array $numbersList)
    #echo $check

    if ($check -eq -1) {
        $answer += 1
    } else {
        $checkAt = 0
        $checkPrev = 0
        $checkNext = 0

        $dropAtIndex = New-Object System.Collections.ArrayList(,$numbersList)
        $dropNextIndex = New-Object System.Collections.ArrayList(,$numbersList)
        $dropPrevIndex = New-Object System.Collections.ArrayList(,$numbersList)

        if ($check -gt 0) {
            $dropPrevIndex.RemoveAt($check - 1)

            $checkPrev = [int] (Check-Array $dropPrevIndex)
        }

        $dropAtIndex.RemoveAt($check)
        $checkAt = [int] (Check-Array $dropAtIndex)

        #echo "$checkAt : $dropAtIndex"

        $dropNextIndex.RemoveAt($check + 1)
        $checkNext = [int] (Check-Array $dropNextIndex)

        if ($checkAt -eq -1) {
            $answer += 1
        } elseif ($checkPrev -eq -1) {
            $answer += 1
        } elseif ($checkNext -eq -1) {
            $answer += 1
        }

        #echo "$checkAt $checkPrev $checkNext : $numbersList : $dropAtIndex : $dropPrevIndex : $dropNextIndex"
    }

}

Write-Host $answer