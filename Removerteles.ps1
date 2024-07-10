# Importar o módulo DhcpServer
Import-Module DhcpServer

# Definir o ScopeID do escopo DHCP que deseja gerenciar
$scopeID = "192.168.0.84"  # Substitua pelo ScopeID correto do seu escopo DHCP

# Obter todas as concessões DHCP do escopo
$leases = Get-DhcpServerv4Lease -ScopeId $scopeID
Write-Host "Lista de concessões: $leases"

# Filtrar concessões de dispositivos móveis
$mobilDevices = $leases | Where-Object {
    $_.HostName -like "*android*" -or
    $_.HostName -like "*windows phone*" -or
    $_.HostName -like "*iphone*" -or
    $_.HostName -like "*ipad*" -or
    $_.HostName -like "*samsung*" -or
    $_.HostName -like "*lg*" -or
    $_.HostName -like "*motorola*" -or
    $_.HostName -like "*nokia*" -or
    $_.HostName -like "*htc*" -or
    $_.HostName -like "*sony*" -or
    $_.HostName -like "*xiaomi*" -or
    $_.HostName -like "*huawei*" -or
    $_.HostName -like "*oneplus*" -or
    $_.HostName -like "*google pixel*" -or
    $_.HostName -like "*blackberry*" -or
    $_.HostName -like "*palm*" -or
    $_.HostName -like "*tablet*" -or
    $_.HostName -like "*mobile*" -or
    $_.HostName -like "*phone*" -or
    $_.HostName -like "*OPPO*" -or
    $_.HostName -like "*Redmi*" -or
    $_.HostName -like "*A33*" -or
    $_.HostName -like "*Galaxi*"
    # ...
}
Write-Host "Lista de dispositivos móveis: $mobilDevices"

foreach ($lease in $mobilDevices) {
    try {
        Remove-DhcpServerv4Lease -IPAddress $lease.IPAddress -ScopeId $lease.ScopeId
        Write-Host "Concessão DHCP removida com sucesso para $($lease.IPAddress)."
    } catch {
        Write-Host "Erro ao remover concessão DHCP:"
        Write-Host "Mensagem de erro: $($_.Exception.Message)"
        Write-Host "Tipo de exceção: $($_.Exception.GetType())"
        Write-Host "Stack Trace:"
        Write-Host $_.Exception.StackTrace
    }
}
