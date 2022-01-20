using System;
using System.Collections.Generic;
using System.Text;

namespace Entities.ModelsDTOs
{
    public class UserGetDto
    {
        public int Id { get; set; }

        public DateTime RegistrationDate { get; set; }

        public string Name { get; set; }

    }
}
