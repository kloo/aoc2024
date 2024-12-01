<#

#>

$strarray = Get-Content ina.txt
$answer = 0

$inputLen = $strarray.Length

$firstNumArray = @()
$secondNumMap = @{}

foreach ($line in $strarray) {
    $inputArray = $line.Split(" ")
    $firstNumVal = [int] $inputArray[0]
    $secondNumVal = [int] $inputArray[3]

    #echo "$firstNumVal $secondNumVal"

    $firstNumArray += $firstNumVal

    if($secondNumMap.ContainsKey($secondNumVal)) {
        $secondNumMap[$secondNumVal]++
    } else {
        $secondNumMap.Add($secondNumVal,1)
    }
}

foreach($number in $firstNumArray) {
    #echo "$number $($secondNumMap[$number])"
    $answer += $number * $secondNumMap[$number]
}

Write-Host $answer