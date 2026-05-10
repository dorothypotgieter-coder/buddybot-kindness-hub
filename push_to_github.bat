@echo off
REM Syncs index.html + photos and pushes to GitHub Pages.
REM Just double-click this file.

cd /d "%~dp0"

echo.
echo ============================================================
echo   BuddyBot Kindness Hub - sync and push to GitHub Pages
echo ============================================================
echo.

REM 1) Clean up any stale git lock files left over from prior runs
if exist ".git\index.lock"               del /f /q ".git\index.lock"
if exist ".git\HEAD.lock"                del /f /q ".git\HEAD.lock"
if exist ".git\objects\maintenance.lock" del /f /q ".git\objects\maintenance.lock"

REM 2) Stage every change in this folder
git add -A

REM 3) Commit if there is anything to commit
git diff --cached --quiet
if %ERRORLEVEL% NEQ 0 (
  echo Committing latest changes...
  git -c user.email="dorothy.potgieter@gmail.com" -c user.name="Dorothy Potgieter" commit -m "Update BuddyBot website"
) else (
  echo No new local changes to commit.
)

echo.
echo Current local commits ahead of GitHub:
git log --oneline origin/main..HEAD
echo.
echo Pushing to origin/main ...
echo.
git push origin main
set EXITCODE=%ERRORLEVEL%
echo.
if %EXITCODE%==0 (
  echo ============================================================
  echo   SUCCESS!  GitHub Pages will rebuild in ~30-60 seconds.
  echo   Then HARD-REFRESH:  Ctrl+F5
  echo   URL:  https://dorothypotgieter-coder.github.io/buddybot-kindness-hub/
  echo ============================================================
) else (
  echo ============================================================
  echo   PUSH FAILED.  See the error message above.
  echo ============================================================
)
echo.
pause
