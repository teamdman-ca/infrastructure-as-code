function Build-Params($params) {
    $rtn = @{ parameters = @{ } };
    foreach ($key in $params.Keys) {
        $rtn.parameters[$key] = @{
            value = $params[$key];
        }
    }
    $rtn = $rtn `
        | ConvertTo-Json -Compress `
        | ForEach-Object { $_ -replace '"', '\"' };
    return $rtn;
}

function Read-Config($path = ".\config.ini", $type="ini") {
    switch ($type) {
        "ini" { $config=Get-Content $path | ConvertFrom-StringData; }
        "json" { $config=Get-Content $path | ConvertFrom-Json; }
    }
    foreach ($key in $config.Keys) {
        Write-Host "Reading variable $key=$($config.$key)";
        Set-Variable -Name $key -Value $config.$key -Scope script;
    }
}