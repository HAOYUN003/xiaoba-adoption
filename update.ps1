# Xiaoba Adoption Guardian - one-click update & deploy to GitHub Pages
# Run via "update.bat" (double-click)

# ===== Config paths (edit here if needed) =====
$SRC_DIR  = "C:\Users\ASUS\小八领养守护官"
$SRC_HTML = "$SRC_DIR\小八领养守护官_GTA5电影版.html"
$DEPLOY   = "C:\Users\ASUS\xiaoba_deploy"

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  Xiaoba - one-click update & deploy" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path $SRC_HTML)) {
  Write-Host "[ERROR] Source HTML not found:" -ForegroundColor Red
  Write-Host "  $SRC_HTML" -ForegroundColor Red
  Read-Host "Press Enter to exit"; exit 1
}

Write-Host "[1/4] Copy HTML ..." -ForegroundColor Yellow
Copy-Item $SRC_HTML "$DEPLOY\index.html" -Force
Write-Host "      index.html copied" -ForegroundColor Green

Write-Host "[2/4] Copy photos ..." -ForegroundColor Yellow
if (Test-Path "$SRC_DIR\photo") {
  if (-not (Test-Path "$DEPLOY\photo")) { New-Item -ItemType Directory -Path "$DEPLOY\photo" | Out-Null }
  Copy-Item "$SRC_DIR\photo\*.jpg" "$DEPLOY\photo\" -Force -ErrorAction SilentlyContinue
  Copy-Item "$SRC_DIR\photo\*.jpeg" "$DEPLOY\photo\" -Force -ErrorAction SilentlyContinue
  Copy-Item "$SRC_DIR\photo\*.png" "$DEPLOY\photo\" -Force -ErrorAction SilentlyContinue
  Write-Host "      photos copied" -ForegroundColor Green
} else {
  Write-Host "      [warn] no photo folder, skip" -ForegroundColor DarkYellow
}

Write-Host "[3/4] Copy video ..." -ForegroundColor Yellow
if (Test-Path "$SRC_DIR\video.mp4") {
  Copy-Item "$SRC_DIR\video.mp4" "$DEPLOY\video.mp4" -Force
  Write-Host "      video.mp4 copied" -ForegroundColor Green
} else {
  Write-Host "      [warn] no video.mp4, skip" -ForegroundColor DarkYellow
}

Write-Host "[4/4] Push to GitHub ..." -ForegroundColor Yellow
Set-Location $DEPLOY
git add -A
git commit -m "update $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
git push

if ($LASTEXITCODE -ne 0) {
  Write-Host ""
  Write-Host "[ERROR] Push failed. Check network / git login." -ForegroundColor Red
  Read-Host "Press Enter to exit"; exit 1
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Green
Write-Host "  DONE - deployed successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "  URL: https://haoyun003.github.io/xiaoba-adoption/" -ForegroundColor Cyan
Write-Host "  Note: wait 1-2 min for GitHub Pages build" -ForegroundColor DarkGray
Write-Host "==========================================" -ForegroundColor Green
Write-Host ""
Read-Host "Press Enter to close"
