# Importar o módulo DhcpServer se ainda não estiver importado
Import-Module DhcpServer

# Definir o ScopeID do escopo DHCP que deseja gerenciar
$scopeID = "192.168.0.0"  # Substitua pelo ScopeID correto do seu escopo DHCP

# Padrão genérico para dispositivos móveis no nome do host
$mobileDevicePattern = "Android|iPhone|iPad|Galaxy|Mobile|Cell|Tablet|Redmi|Xiaomi|Huawei"

# Obter todas as concessões DHCP dentro do escopo especificado
$leases = Get-DhcpServerv4Lease -ScopeId $scopeID -AllLeases

# Verificar se todas as concessões estão ocupadas (opcional, se você deseja verificar antes de remover)
$currentLeases = $leases.Count
Write-Host "Número atual de concessões DHCP: $currentLeases"

# Loop pelas concessões para identificar dispositivos móveis e removê-los
foreach ($lease in $leases) {
    # Verificar se o nome do host indica um dispositivo móvel (critério genérico)
    if ($lease.HostName -match $mobileDevicePattern) {
        Write-Host "Removendo dispositivo móvel com endereço IP: $($lease.IPAddress)"
        try {
            # Remover a concessão DHCP para o dispositivo móvel
            Remove-DhcpServerv4Lease -IPAddress $ipAddressToRemove -ScopeId $scopeID
        }
        catch {
            Write-Host "Erro ao remover concessão DHCP:"
            Write-Host "Mensagem de erro: $($_.Exception.Message)"
            Write-Host "Tipo de exceção: $($_.Exception.GetType())"
            Write-Host "Stack Trace:"
            Write-Host $_.Exception.StackTrace
        }
        
        
       
    }
}
