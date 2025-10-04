using EnvioProductos.API.Models;

namespace EnvioProductos.API.Repositories
{
    public interface IEnvioRepository
    {
        List<Envio> GetAllEnvios();

        Envio GetById(int? id);
        void Update(Envio envio);
    }
}