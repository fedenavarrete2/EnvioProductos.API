using EnvioProductos.API.DTOs;
using EnvioProductos.API.Models;

namespace EnvioProductos.API.Services
{
    /// <summary>
    /// Interfaz para el servicio de Envios
    /// Los estudiantes deben implementar esta interfaz
    /// </summary>
    public interface IEnvioService
    {
        List<Envio> GetEnviosConFiltros(string? direccion, string? estado);
        bool CancelarEnvio(int id);
    }

}