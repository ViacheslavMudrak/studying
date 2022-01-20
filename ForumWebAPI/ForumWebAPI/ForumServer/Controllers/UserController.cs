using AutoMapper;
using Contracts;
using Entities.Models;
using Entities.ModelsDTOs;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ForumServer.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private IRepositoryWrapper _repository;
        private ILoggerManager _logger;
        private IMapper _mapper;

        public UserController(IRepositoryWrapper repository, ILoggerManager logger, IMapper mapper)
        {
            _repository = repository ?? throw new ArgumentNullException(nameof(repository));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        /// <summary>
        /// Get All Users
        /// </summary>
        /// <returns>List of Users</returns>
        /// <response code="200">Returns created item</response>
        /// <response code="400">Null or incorrect object</response>
        /// <response code="500">Error inside controller</response>
        [HttpGet]
        [ProducesResponseType(200)]
        [ProducesResponseType(400)]
        [ProducesResponseType(500)]
        public IActionResult GetAllUsers()
        {
            try
            {
                var users = _repository.UserRepository.GetAllUsers();
                var usersDtos = _mapper.Map<IEnumerable<UserGetDto>>(users);
                _logger.LogInfo("Returned all users from DB");

                return Ok(usersDtos);
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside UserController, action GetAllUsers, message: {ex.Message}");
                
                return StatusCode(500, "Internal server error");
            }        
        }

        [HttpGet("{id}", Name = "GetUserById")]
        public IActionResult GetUserById(int id)
        {
            try
            {
                var user = _repository.UserRepository.GetUserById(id);

                if (user == null) 
                {
                    _logger.LogError($"User with id: {id} not found in DB");
                    return NotFound();
                }

                var userDto = _mapper.Map<UserGetDto>(user);
                _logger.LogInfo($"Returned user with id: {id}");

                return Ok(userDto);
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside UserController, action GetUserById, message: {ex.Message}");

                return StatusCode(500, "Internal server error");
            }
        }

        [HttpPost]
        public IActionResult CreateUser([FromBody] UserPostDto user)
        {
            try
            {
                if (user == null)
                {
                    _logger.LogError("Received from front user object is null");
                    return BadRequest();
                }

                if (!ModelState.IsValid)
                {
                    _logger.LogError("Incorrect user object received from front");
                    return BadRequest();
                }

                var entity = _mapper.Map<User>(user);
                _repository.UserRepository.CreateUser(entity);
                _repository.Save();
                var createdUser = _mapper.Map<UserGetDto>(entity);
                _logger.LogInfo($"Created new user with id: {entity.Id}");

                return CreatedAtRoute("GetUserById", new { id = createdUser.Id }, createdUser);

            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside UserController, action CreateUser, message: {ex.Message}");

                return StatusCode(500, "Internal server error");
            }
        }

        [HttpPut("{id}")]
        [ProducesResponseType(404)]
        public IActionResult UpdateUser(int id, [FromBody] UserPostPutDto user)
        {
            try
            {
                if (user == null)
                {
                    _logger.LogError("Received from front user object is null");
                    return BadRequest();
                }

                if (!ModelState.IsValid)
                {
                    _logger.LogError("Incorrect user object received from front");
                    return BadRequest();
                }

                var entity = _repository.UserRepository.GetUserById(id);

                if (entity == null)
                {
                    _logger.LogError($"User with id: {id} not found in DB");
                    return NotFound();
                }

                _mapper.Map(user, entity);
                _repository.UserRepository.UpdateUser(entity);
                _repository.Save();
                _logger.LogInfo($"User with id: {id} was modified");

                return NoContent();
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside UserController, action UpdateUser, message: {ex.Message}");

                return StatusCode(500, "Internal server error");
            }
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteUser(int id)
        {
            try
            {
                var user = _repository.UserRepository.GetUserById(id);

                if (user == null)
                {
                    _logger.LogError("Received from front user object is null");
                    return NotFound();
                }

                if (_repository.TopicRepository.TopicsByUserId(id).Any())
                {
                    _logger.LogError($"Cannot delete user with id: {id} because it has related topics");
                    return BadRequest($"Cannot delete user with id: {id} because it has related topics");
                }

                if (_repository.PostRepository.PostsByUserId(id).Any())
                {
                    _logger.LogError($"Cannot delete user with id: {id} because it has related posts");
                    return BadRequest($"Cannot delete user with id: {id} because it has related posts");
                }

                if (_repository.LikeRepository.LikesByUserId(id).Any())
                {
                    _logger.LogError($"Cannot delete user with id: {id} because it has related likes");
                    return BadRequest($"Cannot delete user with id: {id} because it has related likes");
                }

                if (_repository.CredentialRepository.GetCredentialByUserId(id) != null)
                {
                    _logger.LogError($"Cannot delete user with id: {id} because it has related credential");
                    return BadRequest($"Cannot delete user with id: {id} because it has related credential");
                }

                _repository.UserRepository.DeleteUser(user);
                _repository.Save();
                _logger.LogInfo($"User with id: {id} was deleted");

                return NoContent();

            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside UserController, action DeleteUser, message: {ex.Message}");
                if (ex.InnerException != null)
                    _logger.LogError($"Error inside UserController, action DeleteUser, InnerException message: {ex.InnerException.Message}");

                return StatusCode(500, "Internal server error");
            }
        }
    }
}
