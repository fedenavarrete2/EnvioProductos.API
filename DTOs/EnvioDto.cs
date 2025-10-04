namespace EnvioProductos.API.DTOs
{
    /// <summary>
    /// DTO para mostrar informaci�n de env�os
    /// </summary>
    public class EnvioDto
    {
        public int Id { get; set; }
        public DateTime FechaEnvio { get; set; }
        public string DireccionDestino { get; set; } = string.Empty;
        public string Estado { get; set; } = string.Empty;
        public string TransportistaNombre { get; set; } = string.Empty;
        public decimal CostoTotal { get; set; }
    }
}