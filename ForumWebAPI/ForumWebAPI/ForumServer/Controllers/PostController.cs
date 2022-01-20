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
    public class PostController : ControllerBase
    {
        private IRepositoryWrapper _repository;
        private ILoggerManager _logger;
        private IMapper _mapper;

        public PostController(IRepositoryWrapper repository, ILoggerManager logger, IMapper mapper)
        {
            _repository = repository ?? throw new ArgumentNullException(nameof(repository));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        [HttpGet]
        public IActionResult GetAllPosts()
        {
            try
            {
                var posts = _repository.PostRepository.GetAllPosts();
                var postsDtos = _mapper.Map<IEnumerable<PostGetDto>>(posts);
                _logger.LogInfo("Returned all posts from DB");

                return Ok(postsDtos);
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside PostController, action GetAllPosts, message: {ex.Message}");

                return StatusCode(500, "Internal server error");
            }
        }

        [HttpGet("{id}", Name = "GetPostsById")]
        public IActionResult GetPostById(int id)
        {
            try
            {
                var post = _repository.PostRepository.GetPostById(id);

                if (post == null)
                {
                    _logger.LogError($"Post with id: {id} not found in DB");
                    return NotFound();
                }

                var postDto = _mapper.Map<PostGetDto>(post);
                _logger.LogInfo($"Returned post with id: {id}");

                return Ok(postDto);
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside PostController, action GetPostsById, message: {ex.Message}");

                return StatusCode(500, "Internal server error");
            }
        }

        [HttpPost]
        public IActionResult CreatePost([FromBody] PostPostPutDto post)
        {
            try
            {
                if (post == null)
                {
                    _logger.LogError("Received from front post object is null");
                    return BadRequest();
                }

                if (!ModelState.IsValid)
                {
                    _logger.LogError("Incorrect post object received from front");
                    return BadRequest();
                }

                var entity = _mapper.Map<Post>(post);
                _repository.PostRepository.CreatePost(entity);
                _repository.Save();
                var createdPost = _mapper.Map<PostGetDto>(entity);
                _logger.LogInfo($"Created new post with id: {entity.Id}");

                return CreatedAtRoute("GetPostsById",
                    new { Id = entity.Id }, createdPost);

            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside PostController, action CreatePost, message: {ex.Message}");
                if (ex.InnerException != null)
                    _logger.LogError($"Error inside PostController, action CreatePost, InnerException message: {ex.InnerException.Message}");

                return StatusCode(500, "Internal server error");
            }
        }

        [HttpPut("{id}")]
        [ProducesResponseType(404)]
        public IActionResult UpdatePost(int id, [FromBody] PostPostPutDto post)
        {
            try
            {
                if (post == null)
                {
                    _logger.LogError("Received from front post object is null");
                    return BadRequest();
                }

                if (!ModelState.IsValid)
                {
                    _logger.LogError("Incorrect post object received from front");
                    return BadRequest();
                }

                var entity = _repository.PostRepository.GetPostById(id);

                if (entity == null)
                {
                    _logger.LogError($"Post with id: {id} not found in DB");
                    return NotFound();
                }

                _mapper.Map(post, entity);
                _repository.PostRepository.UpdatePost(entity);
                _repository.Save();
                _logger.LogInfo($"Post with id: {id} was modified");

                return NoContent();
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside PostController, action UpdatePost, message: {ex.Message}");

                return StatusCode(500, "Internal server error");
            }
        }

        [HttpDelete("{id}")]
        public IActionResult DeletePost(int id)
        {
            try
            {
                var post = _repository.PostRepository.GetPostById(id);

                if (post == null)
                {
                    _logger.LogError("Received from front post object is null");
                    return NotFound();
                }

                if (_repository.LikeRepository.GetLikesByPostId(id).Any())
                {
                    _logger.LogError($"Cannot delete post with id: {id} because it has related likes");
                    return BadRequest($"Cannot delete post with id: {id} because it has related likes");
                }

                if (_repository.ReplyRepository.RepiesByPostId(id).Any())
                {
                    _logger.LogError($"Cannot delete post with id: {id} because it has related replies");
                    return BadRequest($"Cannot delete post with id: {id} because it has related replies");
                }

                _repository.PostRepository.DeletePost(post);
                _repository.Save();
                _logger.LogInfo($"Post with id: {id} was deleted");

                return NoContent();
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error inside PostController, action DeletePost, message: {ex.Message}");
                if (ex.InnerException != null)
                    _logger.LogError($"Error inside PostController, action DeletePost, InnerException message: {ex.InnerException.Message}");

                return StatusCode(500, "Internal server error");
            }
        }

    }
}
