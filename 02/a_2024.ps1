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

foreach ($line in $strarray) {
    $numbers = [int[]] $line.Split(" ")

    $lastChange = 0

    $lastNumIndex = $numbers.Count - 1

    for ($i = 0; $i -lt $lastNumIndex;$i++) {
        $diff = $numbers[$i] - $numbers[$i + 1]

        #if current diff and last diff are pos and neg, don't count
        $checkSameDirection = $lastChange * $diff
        if ($checkSameDirection -lt 0) {
            #echo "Direction"
            break
        } else {
            $lastChange = $diff
        }

        #if current diff is not 1, 2, or 3, don't count
        $diff = [Math]::Abs($diff)
        if ( ($diff -lt 1) -or ($diff -gt 3) ) {
            #echo "range"
            break
        }

        
    }

    if ($i -eq $lastNumIndex) {
        #echo "$i $lastNumIndex"
        $answer += 1
    }

    #echo $answer
}

Write-Host $answer