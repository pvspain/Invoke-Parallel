#! /usr/bin/env pwsh

$upstreamRepoUrl = 'https://github.com/RamblingCookieMonster/Invoke-Parallel'

Push-Location $PSScriptRoot | Out-Null

# Create upstream remote if absent...
if (-not (& git remote | Where-Object {$_ -match 'upstream' })) {
  Write-Output "Creating remote 'upstream'..."  
  & git remote add upstream $upstreamRepoUrl
} 
# Recheck for upstream branch...
if (& git remote | Where-Object {$_ -match 'upstream' }) {
    Write-Output "Fetching changes from 'upstream/master'..."  
    & git fetch upstream
    Write-Output "Checking out local 'master' branch..."  
    & git checkout master
    Write-Output "Merging changes from 'upstream/master'..."  
    & git merge upstream/master
    Write-Output "Pushing changes to 'origin/master'..."  
    & git push
}

Pop-Location | Out-Null