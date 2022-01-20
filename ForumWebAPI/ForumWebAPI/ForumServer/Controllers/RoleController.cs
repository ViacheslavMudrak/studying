using AutoMapper;
using Contracts;
using Entities.Models;
using Entities.ModelsDTOs;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ForumServer.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RoleController : ControllerBase
    {
        private IRepositoryWrapper _repository;
        private ILoggerManager _logger;
        private IMapper _mapper;

        public RoleController(IRepositoryWrapper repository, ILoggerManager logger, IMapper mapper)
        {
            _repository = repository ?? throw new ArgumentNullException(nameof(repository));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        [HttpGet]
        public IActionResult GetAllRoles()
        {
            try
            {
                var roles = _repository.RoleRepository.GetAllRoles();
                var rolesDtos = _mapper.Map<IEnumerable<RoleGetPutDto>>(roles);
                _logger.LogInfo("Returned all roles from DB");

                return Ok(rolesDtos);
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside RoleController, action GetAllRoles, message: {ex.Message}");

                return StatusCode(500, "Internal server error");
            }
        }

        [HttpGet("{id}", Name = "GetRoleById")]
        public IActionResult GetRoleById(int id)
        {
            try
            {
                var role = _repository.RoleRepository.GetRoleById(id);

                if (role == null)
                {
                    _logger.LogError($"Role with id: {id} not found in DB");
                    return NotFound();
                }

                var roleDto = _mapper.Map<RoleGetPutDto>(role);
                _logger.LogInfo($"Returned role with id: {id}");

                return Ok(roleDto);
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside RoleController, action GetRoleById, message: {ex.Message}");

                return StatusCode(500, "Internal server error");
            }
        }

        [HttpPost]
        public IActionResult CreateRole([FromBody] RoleDto role)
        {
            try
            {
                if (role == null)
                {
                    _logger.LogError("Received from front role object is null");
                    return BadRequest();
                }

                if (!ModelState.IsValid)
                {
                    _logger.LogError("Incorrect role object received from front");
                    return BadRequest();
                }

                var entity = _mapper.Map<Role>(role);
                _repository.RoleRepository.CreateRole(entity);
                _repository.Save();
                var createdRole = _mapper.Map<RoleDto>(entity);
                _logger.LogInfo($"Created new role with id: {entity.Id}");

                return CreatedAtRoute("GetRoleById",
                    new { Id = entity.Id }, createdRole);

            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside RoleController, action CreateRole, message: {ex.Message}");
                if (ex.InnerException != null)
                    _logger.LogError($"Error inside RoleController, action CreateRole, InnerException message: {ex.InnerException.Message}");

                return StatusCode(500, "Internal server error");
            }
        }

        [HttpPut("{id}")]
        [ProducesResponseType(404)]
        public IActionResult UpdateRole(int id, [FromBody] RoleGetPutDto role)
        {
            try
            {
                if (role == null)
                {
                    _logger.LogError("Received from front role object is null");
                    return BadRequest();
                }

                if (!ModelState.IsValid)
                {
                    _logger.LogError("Incorrect role object received from front");
                    return BadRequest();
                }

                var entity = _repository.RoleRepository.GetRoleById(id);

                if (entity == null)
                {
                    _logger.LogError($"Role with id: {id} not found in DB");
                    return NotFound();
                }

                _mapper.Map(role, entity);
                _repository.RoleRepository.UpdateRole(entity);
                _repository.Save();
                _logger.LogInfo($"Role with id: {id} was modified");

                return NoContent();
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside RoleController, action UpdateRole, message: {ex.Message}");

                return StatusCode(500, "Internal server error");
            }
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteRole(int id)
        {
            try
            {
                var role = _repository.RoleRepository.GetRoleById(id);

                if (role == null)
                {
                    _logger.LogError("Received from front role object is null");
                    return NotFound();
                }

                if (_repository.UserRepository.UsersByRoleId(id).Any())
                {
                    _logger.LogError($"Cannot delete role with id: {id} because it has related users");
                    return BadRequest($"Cannot delete role with id: {id} because it has related users");
                }

                _repository.RoleRepository.DeleteRole(role);
                _repository.Save();
                _logger.LogInfo($"Role with id: {id} was deleted");

                return NoContent();
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside RoleController, action DeleteRole, message: {ex.Message}");
                if (ex.InnerException != null)
                    _logger.LogError($"Error inside RoleController, action DeleteRole, InnerException message: {ex.InnerException.Message}");

                return StatusCode(500, "Internal server error");
            }
        }

    }
}
