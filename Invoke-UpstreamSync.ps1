#! /usr/bin/env pwsh

$upstreamRepoUrl = 'https://github.com/RamblingCookieMonster/Invoke-Parallel'

Push-Location $PSScriptRoot | Out-Null

# Create upstream remote if absent...
if (-not (& git remote | Where-Object { $_ -eq 'upstream' })) {
  Write-Output "Creating remote 'upstream'..."  
  & git remote add upstream $upstreamRepoUrl
} 
# Recheck for upstream remote...
if (& git remote | Where-Object { $_ -eq 'upstream' }) {
    Write-Output "Fetching changes from 'upstream/master'..."  
    & git fetch upstream
    Write-Output "Checking out local 'master' branch..."  
    & git checkout master
    Write-Output "Stashing local changes..."  
    & git stash push
    Write-Output "Merging changes from 'upstream/master'..."  
    & git merge upstream/master
    Write-Output "Pushing changes to 'origin/master'..."  
    & git push
    Write-Output "Unstashing local changes..."  
    & git stash pop
}

Pop-Location | Out-Null