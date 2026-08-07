@echo off
chcp 65001 >nul
rem Xiaoba update launcher
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0update.ps1"
