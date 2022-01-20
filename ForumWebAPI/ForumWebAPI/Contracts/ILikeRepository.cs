using Entities.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace Contracts
{
    public interface ILikeRepository : IRepositoryBase<Like>
    {
        Like LikeByPostIdAndUserId(int postId, int userId);

        IEnumerable<Like> LikesByUserId(int userId);

        // HttpGet
        IEnumerable<Like> GetAllLikes();
        IEnumerable<Like> GetLikesByPostId(int id);

        // HttpPost
        void CreateLike(Like like);

        // HttpPut
        void UpdateLike(Like like);

        // HttpDelete
        void DeleteLike(Like like);
    }
}
