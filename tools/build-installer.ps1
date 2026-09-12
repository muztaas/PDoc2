$ErrorActionPreference = "Stop"

# Bundle Python first
& (Join-Path $PSScriptRoot "bundle-python.ps1")

$rootDir = Split-Path $PSScriptRoot -Parent
$solutionPath = Join-Path $rootDir "PDoc2.sln"
$projectPath = Join-Path $rootDir "src\PDoc\PDoc2.csproj"
$installerScript = Join-Path $PSScriptRoot "installer.iss"

# Build the solution
dotnet restore $solutionPath
dotnet build $solutionPath -c Release
$publishDir = Join-Path $rootDir "src\PDoc\bin\Release\net9.0-windows7.0\win-x64\publish"
dotnet publish $projectPath -c Release -r win-x64 --self-contained true --output $publishDir

if (-not (Test-Path (Join-Path $publishDir "PDoc2.exe"))) {
	throw "Self-contained publish did not produce PDoc2.exe in $publishDir"
}

# Create installer
$isccCandidates = @(
	"C:\Program Files (x86)\Inno Setup 6\ISCC.exe",
	"C:\Program Files\Inno Setup 6\ISCC.exe",
	(Join-Path $env:LOCALAPPDATA "Programs\Inno Setup 6\ISCC.exe")
)
$isccPath = $isccCandidates | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $isccPath) {
	throw "Inno Setup compiler not found. Install Inno Setup 6 before building the installer."
}

& $isccPath $installerScript
if ($LASTEXITCODE -ne 0) {
	throw "Inno Setup failed with exit code $LASTEXITCODE."
}