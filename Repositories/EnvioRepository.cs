using EnvioProductos.API.Models;

namespace EnvioProductos.API.Repositories
{
    public class EnvioRepository : IEnvioRepository
    {
        private EnvioProductosDBContext _db;

        public EnvioRepository(EnvioProductosDBContext db)
        {
            _db = db;
        }

        public List<Envio> GetAllEnvios()
        {
            return _db.Envios.ToList();
        }

        public Envio GetById(int? id)
        {
            return _db.Envios.Find(id);
        }

        public void Update(Envio envio)
        {
            _db.Envios.Update(envio);
            _db.SaveChanges();
        }
    }
}
