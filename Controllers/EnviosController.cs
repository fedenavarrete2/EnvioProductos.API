using Microsoft.AspNetCore.Mvc;
using EnvioProductos.API.Services;
using EnvioProductos.API.DTOs;

namespace EnvioProductos.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class EnviosController : ControllerBase
    {
        private IEnvioService _service;

        public EnviosController(IEnvioService service)
        {
            _service = service;
        }

        [HttpGet("filtrar")]
        public IActionResult GetEnviosConFiltros([FromQuery] string? direccion, [FromQuery] string? estado)
        {
            var envios = _service.GetEnviosConFiltros(direccion, estado);
            return Ok(envios);
        }

        [HttpDelete("{id}")]
        public IActionResult CancelarEnvio(int id)
        {
            try
            {
                _service.CancelarEnvio(id);
                return Ok(new { mensaje = "Envío cancelado correctamentee." });
            }
            catch (Exception ex)
            {
                return BadRequest(new { error = ex.Message });
            }
        }
    }
}