
echo "Building WASM..."
wasm-pack build . --target web --dev

echo "Assembling playground..."
rmdir /S /q site
mkdir _site\pkg

copy pkg\wasm_bg.wasm _site\pkg\
copy pkg\wasm.js _site\pkg\
copy playground\index.html _site\
copy playground\monarch.js _site\
copy playground\editor.js _site\
copy playground\files.js _site\
copy playground\prefabs.js _site\
copy playground\share.js _site\
copy playground\docs.js _site\

echo "Copying docs + examples..."
mkdir _site\docs _site\sdk\examples
copy ..\..\docs\wirescript\*.md _site\docs\
node playground\build-search-index.mjs _site\docs _site\docs\search-index.json
copy playground\sdk\examples\*.ws _site\sdk\examples\

echo "Building SDK zip..."
rmdir /S /q _sdk
mkdir _sdk\wirescript-sdk\pkg _sdk\wirescript-sdk\playground\pkg _sdk\wirescript-sdk\examples

copy pkg\wasm_bg.wasm _sdk\wirescript-sdk\pkg\
copy pkg\wasm.js _sdk\wirescript-sdk\pkg\
copy playground\sdk\check.mjs _sdk\wirescript-sdk\
copy playground\sdk\compile.mjs _sdk\wirescript-sdk\
copy playground\sdk\format.mjs _sdk\wirescript-sdk\
copy playground\sdk\hover.mjs _sdk\wirescript-sdk\
copy playground\sdk\CLAUDE.md _sdk\wirescript-sdk\
copy playground\sdk\README.md _sdk\wirescript-sdk\
copy playground\docs.js _sdk\wirescript-sdk\
copy playground\sdk\examples\*.ws _sdk\wirescript-sdk\examples\

copy playground\index.html _sdk\wirescript-sdk\playground\
copy playground\monarch.js _sdk\wirescript-sdk\playground\
copy playground\editor.js _sdk\wirescript-sdk\playground\
copy playground\files.js _sdk\wirescript-sdk\playground\
copy playground\prefabs.js _sdk\wirescript-sdk\playground\
copy playground\share.js _sdk\wirescript-sdk\playground\
copy playground\docs.js _sdk\wirescript-sdk\playground\
copy pkg\wasm_bg.wasm _sdk\wirescript-sdk\playground\pkg\
copy pkg\wasm.js _sdk\wirescript-sdk\playground\pkg\

mkdir _sdk\wirescript-sdk\vscode\syntaxes _sdk\wirescript-sdk\vscode\pkg
copy playground\sdk\vscode\extension.js _sdk\wirescript-sdk\vscode\
copy playground\sdk\vscode\package.json _sdk\wirescript-sdk\vscode\
copy ..\..\editors\vscode\language-configuration.json _sdk\wirescript-sdk\vscode\
copy ..\..\editors\vscode\syntaxes\wirescript.tmLanguage.json _sdk\wirescript-sdk\vscode\syntaxes\
copy pkg\wasm_bg.wasm _sdk\wirescript-sdk\vscode\pkg\
copy pkg\wasm.js _sdk\wirescript-sdk\vscode\pkg\

cd _sdk
START /WAIT "" "powershell" -Command "Compress-Archive -Force -Path .\wirescript-sdk  -DestinationPath ..\wirescript-sdk.zip"
cd ..
rmdir /S /q _sdk
copy wirescript-sdk.zip _site\

echo Done! Files:
echo   _site\               - serve with any HTTP server
echo   wirescript-sdk.zip   - downloadable SDK with CLI tools