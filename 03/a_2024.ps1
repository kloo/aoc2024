<#

#>

$strarray = Get-Content ina.txt
$answer = 0

$inputLen = $strarray.Length
$inputArray = New-Object int[] $inputLen

Function Get-LineSum {
    Param (
        [string] $inputString
    )
    
    
}

foreach ($line in $strarray) {

    $regexString = [regex] "mul\(\d+,\d+\)"

    $lineSum = 0

    $regexString.Matches($line) | ForEach-Object {
        $operation = ($_.Value).Split("(),")
        #Write-Host "$operation"

        $lineSum += ([int] $operation[1]) * ([int] $operation[2])
    }

    $answer += $lineSum
}

Write-Host $answer