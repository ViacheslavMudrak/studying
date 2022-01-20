using Contracts;
using Entities;
using Entities.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Repository
{
    public class LikeRepository : RepositoryBase<Like>, ILikeRepository
    {
        public LikeRepository(RepositoryContext repositoryContext) 
            : base(repositoryContext)
        {
        }

        public Like LikeByPostIdAndUserId(int postId, int userId)
        {
            return FindByCondition(l => l.PostId.Equals(postId) && l.UserId.Equals(userId)).FirstOrDefault();
        }

        public IEnumerable<Like> LikesByUserId(int userId)
        {
            return FindByCondition(l => l.UserId.Equals(userId)).ToList();
        }

        public IEnumerable<Like> GetAllLikes()
        {
            return FindAll().OrderBy(l => l.PostId).ToList();
        }

        public IEnumerable<Like> GetLikesByPostId(int id)
        {
            return FindByCondition(l => l.PostId.Equals(id)).ToList();
        }

        public void CreateLike(Like like)
        {
            Create(like);
        }

        public void UpdateLike(Like like)
        {
            Update(like);
        }

        public void DeleteLike(Like like)
        {
            Delete(like);
        }

    }
}
