using Entities.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace Contracts
{
    public interface IPostRepository : IRepositoryBase<Post>
    {
        IEnumerable<Post> PostsByUserId(int id);
        IEnumerable<Post> PostsByTopicId(int id);

        // HttpGet
        IEnumerable<Post> GetAllPosts();
        Post GetPostById(int id);

        // HttpPost
        void CreatePost(Post post);

        // HttpPut
        void UpdatePost(Post post);

        // HttpDelete
        void DeletePost(Post post);
    }
}
