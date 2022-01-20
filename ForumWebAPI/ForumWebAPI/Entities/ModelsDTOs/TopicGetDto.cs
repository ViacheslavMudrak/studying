using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace Entities.ModelsDTOs
{
    public class TopicGetDto
    {
        public DateTime DateTime { get; set; }

        public string TopicName { get; set; }

        public string Description { get; set; }

    }
}
