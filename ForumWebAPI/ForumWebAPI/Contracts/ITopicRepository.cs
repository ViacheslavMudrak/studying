using Entities.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace Contracts
{
    public interface ITopicRepository : IRepositoryBase<Topic>
    {
        IEnumerable<Topic> TopicsByUserId(int userId);

        // HttpGet
        IEnumerable<Topic> GetAllTopics();
        Topic GetTopicById(int id);

        // HttpPost
        void CreateTopic(Topic topic);

        // HttpPut
        void UpdateTopic(Topic topic);

        // HttpDelete
        void DeleteTopic(Topic topic);
    }
}
