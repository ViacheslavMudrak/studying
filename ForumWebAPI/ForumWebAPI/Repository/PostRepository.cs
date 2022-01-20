using Contracts;
using Entities;
using Entities.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Repository
{
    public class PostRepository : RepositoryBase<Post>, IPostRepository
    {
        public PostRepository(RepositoryContext repositoryContext) 
            : base(repositoryContext)
        {                
        }

        public IEnumerable<Post> PostsByUserId(int userId)
        {
            return FindByCondition(p => p.UserId.Equals(userId)).ToList();
        }

        public IEnumerable<Post> PostsByTopicId(int topicId)
        {
            return FindByCondition(p => p.TopicId.Equals(topicId)).ToList();
        }

        public IEnumerable<Post> GetAllPosts()
        {
            return FindAll().ToList();
        }

        public Post GetPostById(int id)
        {
            return FindByCondition(p => p.Id.Equals(id)).FirstOrDefault();
        }

        public void CreatePost(Post post)
        {
            Create(post);
        }

        public void UpdatePost(Post post)
        {
            Update(post);
        }

        public void DeletePost(Post post)
        {
            Delete(post);
        }
    }
}
