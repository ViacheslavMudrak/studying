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
    public class LikeController : ControllerBase
    {
        private IRepositoryWrapper _repository;
        private ILoggerManager _logger;
        private IMapper _mapper;

        public LikeController(IRepositoryWrapper repository, ILoggerManager logger, IMapper mapper)
        {
            _repository = repository ?? throw new ArgumentNullException(nameof(repository));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        [HttpGet]
        public IActionResult GetAllLikes()
        {
            try
            {
                var likes = _repository.LikeRepository.GetAllLikes();
                var likesDtos = _mapper.Map<IEnumerable<LikeGetDto>>(likes);
                _logger.LogInfo("Returned all likes from DB");

                return Ok(likesDtos);
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside LikeController, action GetAllLikes, message: {ex.Message}");

                return StatusCode(500, "Internal server error");
            }
        }

        [HttpGet("{postId}", Name = "GetLikesByPostId")]
        public IActionResult GetLikesByPostId(int postId)
        {
            try
            {
                var likes = _repository.LikeRepository.GetLikesByPostId(postId);

                if (likes == null)
                {
                    _logger.LogError($"Likes with post id: {postId} not found in DB");
                    return NotFound();
                }

                var likesDtos = _mapper.Map<IEnumerable<LikeGetDto>>(likes);
                _logger.LogInfo($"Returned likes with post id: {postId}");

                return Ok(likesDtos);
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside LikeController, action GetLikesByPostId, message: {ex.Message}");

                return StatusCode(500, "Internal server error");
            }
        }

        [HttpPost]
        public IActionResult CreateLike([FromBody] LikePostPutDto like)
        {
            try
            {
                if (like == null)
                {
                    _logger.LogError("Received from front like object is null");
                    return BadRequest();
                }

                if (!ModelState.IsValid)
                {
                    _logger.LogError("Incorrect like object received from front");
                    return BadRequest();
                }

                var entity = _mapper.Map<Like>(like);
                _repository.LikeRepository.CreateLike(entity);
                _repository.Save();
                var createdLike = _mapper.Map<LikeGetDto>(entity);
                _logger.LogInfo($"Created new like for post with id: {entity.PostId} by user with id: {entity.UserId}");

                return CreatedAtRoute("GetLikesByPostId",
                    new { PostId = createdLike.PostId }, createdLike);

            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside LikeController, action CreateLike, message: {ex.Message}");
                if (ex.InnerException != null)
                    _logger.LogError($"Error inside LikeController, action CreateLike, InnerException message: {ex.InnerException.Message}");

                return StatusCode(500, "Internal server error");
            }
        }

        [HttpPut("{postId}/{userId}")]
        [ProducesResponseType(404)]
        public IActionResult UpdateLike(int postId, int userId, [FromBody] LikePostPutDto like)
        {
            try
            {
                if (like == null)
                {
                    _logger.LogError("Received from front like object is null");
                    return BadRequest();
                }

                if (!ModelState.IsValid)
                {
                    _logger.LogError("Incorrect like object received from front");
                    return BadRequest();
                }

                var entity = _repository.LikeRepository.LikeByPostIdAndUserId(postId, userId);

                if (entity == null)
                {
                    _logger.LogError($"Like with post id: {postId} and user id: {userId} not found in DB");
                    return NotFound();
                }

                _mapper.Map(like, entity);
                _repository.LikeRepository.UpdateLike(entity);
                _repository.Save();
                _logger.LogInfo($"Like with post id: {postId} and user id: {userId} was modified");

                return NoContent();
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside LikeController, action UpdateLike, message: {ex.Message}");

                return StatusCode(500, "Internal server error");
            }
        }

        [HttpDelete("{postId}/{userId}")]
        public IActionResult DeleteLike(int postId, int userId)
        {
            try
            {
                var like = _repository.LikeRepository.LikeByPostIdAndUserId(postId, userId);

                if (like == null)
                {
                    _logger.LogError("Received from front like object is null");
                    return NotFound();
                }

                _repository.LikeRepository.DeleteLike(like);
                _repository.Save();
                _logger.LogInfo($"Like with post id: {postId} and user id: {userId} was deleted");

                return NoContent();

            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside LikeController, action DeleteLike, message: {ex.Message}");
                if (ex.InnerException != null)
                    _logger.LogError($"Error inside LikeController, action DeleteLike, InnerException message: {ex.InnerException.Message}");

                return StatusCode(500, "Internal server error");
            }
        }

    }
}
