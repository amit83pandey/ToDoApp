Param($intOne = 5, $intTwo = 3)
Function add-numbers([int]$intOne, [int]$intTwo)
{
	$intOne + $intTwo
}
Function Test([string]$var1, [string]$var2)
{
	Write-Host: "`$var1 value: $var1"
	Write-Host: "`$var2 value: $var2" 
}
