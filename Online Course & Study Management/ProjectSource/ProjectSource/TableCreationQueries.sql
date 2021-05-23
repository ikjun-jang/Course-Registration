CREATE TABLE `advisor` (
  `advisor_id` varchar(11) NOT NULL DEFAULT '',
  `department_id` int(11) NOT NULL,
  `advisor_name` varchar(255) NOT NULL,
  PRIMARY KEY (`advisor_id`),
  KEY `department_id` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `courseactivities` (
  `course_number` int(11) NOT NULL,
  `semester` varchar(255) NOT NULL,
  `activity_name` varchar(255) NOT NULL,
  `activity_description` varchar(255) DEFAULT NULL,
  `posted_on` datetime DEFAULT NULL,
  `deadline` datetime DEFAULT NULL,
  `professor_id` varchar(11) DEFAULT NULL,
  `activity_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`course_number`,`activity_name`),
  CONSTRAINT `courseactivities_ibfk_1` FOREIGN KEY (`course_number`) REFERENCES `offeredcourses` (`course_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `courseprerequisites` (
  `course_number` int(11) NOT NULL,
  `prequisite_course_number` int(11) NOT NULL,
  PRIMARY KEY (`course_number`,`prequisite_course_number`),
  CONSTRAINT `courseprerequisites_ibfk_1` FOREIGN KEY (`course_number`) REFERENCES `courses` (`course_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `courses` (
  `course_number` int(11) NOT NULL,
  `course_name` varchar(255) NOT NULL,
  `credits` int(11) DEFAULT NULL,
  PRIMARY KEY (`course_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `department` (
  `department_id` int(11) NOT NULL,
  `department_name` varchar(255) NOT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `enrolledprograms` (
  `student_id` varchar(11) DEFAULT NULL,
  `program_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `offeredcourses` (
  `course_number` int(11) NOT NULL,
  `semester` varchar(255) NOT NULL,
  `course_instructor` varchar(255) NOT NULL,
  `instruction_method` varchar(255) NOT NULL,
  `course_prefix` varchar(255) NOT NULL,
  `course_timing` varchar(255) NOT NULL,
  `course_location` varchar(255) NOT NULL,
  `seats_available` int(11) NOT NULL,
  `maximum_seats` int(11) NOT NULL,
  `status` varchar(50) NOT NULL,
  `professor_id` varchar(11) DEFAULT NULL,
  `course_level` varchar(55) DEFAULT NULL,
  PRIMARY KEY (`course_number`,`semester`),
  CONSTRAINT `offeredcourses_ibfk_1` FOREIGN KEY (`course_number`) REFERENCES `courses` (`course_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `programprerequisites` (
  `program_id` int(11) NOT NULL,
  `course_number` int(11) NOT NULL,
  PRIMARY KEY (`program_id`,`course_number`),
  KEY `course_number` (`course_number`),
  CONSTRAINT `programprerequisites_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `programs` (`program_id`),
  CONSTRAINT `programprerequisites_ibfk_2` FOREIGN KEY (`course_number`) REFERENCES `courses` (`course_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `programs` (
  `program_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `program_name` varchar(255) NOT NULL,
  `program_level` varchar(255) NOT NULL,
  `program_prefix` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`program_id`,`department_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `programs_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `registeredcourses` (
  `student_id` varchar(11) DEFAULT NULL,
  `course_number` int(11) DEFAULT NULL,
  `course_sem` varchar(25) DEFAULT NULL,
  `reg_status` varchar(25) DEFAULT NULL,
  `student_grade` varchar(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `studenprereqs` (
  `student_id` varchar(11) DEFAULT NULL,
  `course_num` int(11) DEFAULT NULL,
  `prereq_status` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `student` (
  `student_id` int(11) NOT NULL,
  `student_netid` varchar(10) NOT NULL,
  `student_advisor` varchar(11) DEFAULT NULL,
  KEY `student_advisor` (`student_advisor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `studentrequests` (
  `request_id` int(11) NOT NULL,
  `student_id` varchar(11) DEFAULT NULL,
  `advisor_id` varchar(11) DEFAULT NULL,
  `request_description` varchar(255) NOT NULL,
  `course_number` int(11) DEFAULT NULL,
  `request_status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `studyplans` (
  `plan_id` int(11) NOT NULL,
  `plan_name` varchar(255) NOT NULL,
  `student_id` varchar(11) NOT NULL DEFAULT '',
  PRIMARY KEY (`plan_id`,`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tasks` (
  `plan_id` int(11) NOT NULL,
  `student_id` varchar(11) NOT NULL DEFAULT '',
  `task_id` int(11) NOT NULL,
  `task_name` varchar(255) NOT NULL,
  `task_priority` int(11) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  PRIMARY KEY (`student_id`,`plan_id`,`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `universityrules` (
  `rule_name` varchar(25) DEFAULT NULL,
  `rule_value` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user` (
  `user_id` varchar(11) NOT NULL DEFAULT '',
  `user_pwd` varchar(255) DEFAULT NULL,
  `user_role` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;







