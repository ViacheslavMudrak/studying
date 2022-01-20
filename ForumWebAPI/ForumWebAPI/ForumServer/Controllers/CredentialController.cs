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
    public class CredentialController : ControllerBase
    {
        private IRepositoryWrapper _repository;
        private ILoggerManager _logger;
        private IMapper _mapper;

        public CredentialController(IRepositoryWrapper repository, ILoggerManager logger, IMapper mapper)
        {
            _repository = repository ?? throw new ArgumentNullException(nameof(repository));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        [HttpGet]
        public IActionResult GetAllCredentials()
        {
            try
            {
                var credentials = _repository.CredentialRepository.GetAllCredentials();
                var credentialsDtos = _mapper.Map<IEnumerable<CredentialGetDto>>(credentials);
                _logger.LogInfo("Returned all credentials from DB");

                return Ok(credentialsDtos);
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside CredentialsController, action GetAllCredentials, message: {ex.Message}");

                return StatusCode(500, "Internal server error");
            }
        }

        [HttpGet("{userId}", Name = "GetCredentialByUserId")]
        public IActionResult GetCredentialByUserId(int userId)
        {
            try
            {
                var credential = _repository.CredentialRepository.GetCredentialByUserId(userId);

                if (credential == null)
                {
                    _logger.LogError($"Credential with user id: {userId} not found in DB");
                    return NotFound();
                }

                var credentialDto = _mapper.Map<CredentialGetDto>(credential);
                _logger.LogInfo($"Returned credential with user id: {userId}");

                return Ok(credentialDto);
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside CredentialsController, action GetCredentialByUserId, message: {ex.Message}");

                return StatusCode(500, "Internal server error");
            }
        }

        [HttpPost]
        public IActionResult CreateCredential([FromBody] CredentialPostDto credential)
        {
            try
            {
                if (credential == null)
                {
                    _logger.LogError("Received from front credential object is null");
                    return BadRequest();
                }

                if (!ModelState.IsValid)
                {
                    _logger.LogError("Incorrect credential object received from front");
                    return BadRequest();
                }

                var entity = _mapper.Map<Credential>(credential);
                _repository.CredentialRepository.CreateCredential(entity);
                _repository.Save();
                var createdCredential = _mapper.Map<CredentialGetDto>(entity);
                _logger.LogInfo($"Created new credential with user id: {entity.UserId}");

                return CreatedAtRoute("GetCredentialByUserId", 
                    new { UserId = createdCredential.UserId }, createdCredential);

            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside CredentialsController, action CreateCredential, message: {ex.Message}");

                return StatusCode(500, "Internal server error");
            }
        }

        [HttpPut("{userId}")]
        [ProducesResponseType(404)]
        public IActionResult UpdateCredential(int userId, [FromBody] CredentialPostPutDto credential)
        {
            try
            {
                if (credential == null)
                {
                    _logger.LogError("Received from front credential object is null");
                    return BadRequest();
                }

                if (!ModelState.IsValid)
                {
                    _logger.LogError("Incorrect credential object received from front");
                    return BadRequest();
                }

                var entity = _repository.CredentialRepository.GetCredentialByUserId(userId);

                if (entity == null)
                {
                    _logger.LogError($"Credential with user id: {userId} not found in DB");
                    return NotFound();
                }

                _mapper.Map(credential, entity);
                _repository.CredentialRepository.UpdateCredential(entity);
                _repository.Save();
                _logger.LogInfo($"Credential with user id: {userId} was modified");

                return NoContent();
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside CredentialsController, action UpdateCredential, message: {ex.Message}");

                return StatusCode(500, "Internal server error");
            }
        }

        [HttpDelete("{userId}")]
        public IActionResult DeleteCredential(int userId)
        {
            try
            {
                var credential = _repository.CredentialRepository.GetCredentialByUserId(userId);

                if (credential == null)
                {
                    _logger.LogError("Received from front credential object is null");
                    return NotFound();
                }

                _repository.CredentialRepository.DeleteCredential(credential);
                _repository.Save();
                _logger.LogInfo($"Credential with user id: {userId} was deleted");

                return NoContent();

            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside CredentialsController, action DeleteCredential, message: {ex.Message}");
                if (ex.InnerException != null)
                    _logger.LogError($"Error inside CredentialsController, action DeleteCredential, InnerException message: {ex.InnerException.Message}");

                return StatusCode(500, "Internal server error");
            }
        }

    }
}
