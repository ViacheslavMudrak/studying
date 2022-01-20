using Contracts;
using Entities;
using Entities.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Repository
{
    public class TopicRepository : RepositoryBase<Topic>, ITopicRepository
    {
        public TopicRepository(RepositoryContext repositoryContext) 
            : base(repositoryContext)
        {
        }

        public IEnumerable<Topic> TopicsByUserId(int userId)
        {
            return FindByCondition(t => t.UserId.Equals(userId)).ToList();
        }

        public IEnumerable<Topic> GetAllTopics()
        {
            return FindAll().ToList();
        }

        public Topic GetTopicById(int id)
        {
            return FindByCondition(t => t.Id.Equals(id)).FirstOrDefault();
        }

        public void CreateTopic(Topic topic)
        {
            Create(topic);
        }

        public void UpdateTopic(Topic topic)
        {
            Update(topic);
        }

        public void DeleteTopic(Topic topic)
        {
            Delete(topic);
        }

    }
}
