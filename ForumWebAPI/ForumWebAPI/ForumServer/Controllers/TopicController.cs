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
    public class TopicController : ControllerBase
    {
        private IRepositoryWrapper _repository;
        private ILoggerManager _logger;
        private IMapper _mapper;

        public TopicController(IRepositoryWrapper repository, ILoggerManager logger, IMapper mapper)
        {
            _repository = repository ?? throw new ArgumentNullException(nameof(repository));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        [HttpGet]
        public IActionResult GetAllTopics()
        {
            try
            {
                var topics = _repository.TopicRepository.GetAllTopics();
                var topicsDtos = _mapper.Map<IEnumerable<TopicGetDto>>(topics);
                _logger.LogInfo("Returned all roles from DB");

                return Ok(topicsDtos);
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside TopicController, action GetAllTopics, message: {ex.Message}");

                return StatusCode(500, "Internal server error");
            }
        }

        [HttpGet("{id}", Name = "GetTopicById")]
        public IActionResult GetTopicById(int id)
        {
            try
            {
                var topic = _repository.TopicRepository.GetTopicById(id);

                if (topic == null)
                {
                    _logger.LogError($"Topic with id: {id} not found in DB");
                    return NotFound();
                }

                var topicDto = _mapper.Map<TopicGetDto>(topic);
                _logger.LogInfo($"Returned topic with id: {id}");

                return Ok(topicDto);
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside TopicController, action GetTopicById, message: {ex.Message}");

                return StatusCode(500, "Internal server error");
            }
        }

        [HttpPost]
        public IActionResult CreateTopic([FromBody] TopicPostPutDto topic)
        {
            try
            {
                if (topic == null)
                {
                    _logger.LogError("Received from front topic object is null");
                    return BadRequest();
                }

                if (!ModelState.IsValid)
                {
                    _logger.LogError("Incorrect topic object received from front");
                    return BadRequest();
                }

                var entity = _mapper.Map<Topic>(topic);
                _repository.TopicRepository.CreateTopic(entity);
                _repository.Save();
                var createdTopic = _mapper.Map<TopicGetDto>(entity);
                _logger.LogInfo($"Created new topic with id: {entity.Id}");

                return CreatedAtRoute("GetTopicById",
                    new { Id = entity.Id }, createdTopic);

            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside TopicController, action CreateTopic, message: {ex.Message}");
                if (ex.InnerException != null)
                    _logger.LogError($"Error inside TopicController, action CreateTopic, InnerException message: {ex.InnerException.Message}");

                return StatusCode(500, "Internal server error");
            }
        }

        [HttpPut("{id}")]
        [ProducesResponseType(404)]
        public IActionResult UpdateTopic(int id, [FromBody] TopicPostPutDto topic)
        {
            try
            {
                if (topic == null)
                {
                    _logger.LogError("Received from front topic object is null");
                    return BadRequest();
                }

                if (!ModelState.IsValid)
                {
                    _logger.LogError("Incorrect topic object received from front");
                    return BadRequest();
                }

                var entity = _repository.TopicRepository.GetTopicById(id);

                if (entity == null)
                {
                    _logger.LogError($"Topic with id: {id} not found in DB");
                    return NotFound();
                }

                _mapper.Map(topic, entity);
                _repository.TopicRepository.UpdateTopic(entity);
                _repository.Save();
                _logger.LogInfo($"Topic with id: {id} was modified");

                return NoContent();
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside TopicController, action UpdateTopic, message: {ex.Message}");

                return StatusCode(500, "Internal server error");
            }
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteTopic(int id)
        {
            try
            {
                var topic = _repository.TopicRepository.GetTopicById(id);

                if (topic == null)
                {
                    _logger.LogError("Received from front topic object is null");
                    return NotFound();
                }

                if (_repository.PostRepository.PostsByTopicId(id).Any())
                {
                    _logger.LogError($"Cannot delete topic with id: {id} because it has related posts");
                    return BadRequest($"Cannot delete topic with id: {id} because it has related posts");
                }

                _repository.TopicRepository.DeleteTopic(topic);
                _repository.Save();
                _logger.LogInfo($"Topic with id: {id} was deleted");

                return NoContent();
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside TopicController, action DeleteTopic, message: {ex.Message}");
                if (ex.InnerException != null)
                    _logger.LogError($"Error inside TopicController, action DeleteTopic, InnerException message: {ex.InnerException.Message}");

                return StatusCode(500, "Internal server error");
            }
        }
    }
}
