<#

#>

$strarray = Get-Content ina.txt
$answer = 0

$inputLen = $strarray.Length

$firstNumList = @()
$secondNumList = @()

foreach ($line in $strarray) {
    $inputArray = $line.Split(" ")
    $firstNumList += [int] $inputArray[0]
    $secondNumList += [int] $inputArray[3]
}

$firstNumList = $firstNumList | Sort-Object
$secondNumList = $secondNumList | Sort-Object

$answer = 0
for($i = 0;$i -lt $firstNumList.Count;$i++) {
    $answer += [Math]::Abs($firstNumList[$i] - $secondNumList[$i])
}

Write-Host $answer