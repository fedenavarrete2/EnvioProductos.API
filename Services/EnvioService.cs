using EnvioProductos.API.Models;
using EnvioProductos.API.Repositories;

namespace EnvioProductos.API.Services
{
    public class EnvioService : IEnvioService
    {
        private IEnvioRepository _repository;

        public EnvioService(IEnvioRepository repository)
        {
            _repository = repository;
        }

        public List<Envio> GetEnviosConFiltros(string? direccion, string? estado)
        {
            var envios = _repository.GetAllEnvios();

            if (!string.IsNullOrEmpty(direccion))
            {
                envios = envios.Where(e => e.DireccionDestino.Contains(direccion)).ToList();
            }

            if (!string.IsNullOrEmpty(estado))
            {
                envios = envios.Where(e => e.Estado == estado).ToList();
            }

            return envios;
        }

        public bool CancelarEnvio(int id)
        {
            var envio = _repository.GetById(id);

            if (envio == null)
                throw new Exception("Envío no encontrado");

            if (envio.Estado == "Cancelado")
                throw new Exception("El envío ya fue cancelado");

            envio.Estado = "Cancelado";
            _repository.Update(envio);

            return true;
        }
    }
}
