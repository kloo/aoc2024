<#
78965138 high
72437895 low
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

$enabled = 1

foreach ($line in $strarray) {

    $regexMulString = [regex] "mul\(\d+,\d+\)"
    $regexDoString = [regex] "do\(\)"
    $regexDontString = [regex] "don\'t\(\)"

    $commandMap = @{}

    $lineSum = 0

    $regexMulString.Matches($line) | ForEach-Object { $commandMap.Add($_.Index,$_.Value) }
    $regexDoString.Matches($line) | ForEach-Object { $commandMap.Add($_.Index,$_.Value) }
    $regexDontString.Matches($line) | ForEach-Object { $commandMap.Add($_.Index,$_.Value) }

    $orderedKeys = $commandMap.Keys | Sort

    for ($i = 0;$i -lt $orderedKeys.Count;$i++) {
        #echo "$key $($commandMap[$key])"
        $key = $orderedKeys[$i]

        $command = $commandMap[$key].Split("(),")

        if ($command[0] -eq "do") {
            $enabled = 1
        } elseif ($command[0] -eq "don't") {
            $enabled = 0
        } elseif ($command[0] -eq "mul") {
            
            $addition = (([int] $command[1]) * ([int] $command[2])) * $enabled
            $answer += $addition

            #echo "$enabled $addition $answer"
        }
    }
}

Write-Host $answer