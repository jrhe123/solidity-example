// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

struct TODO {
    string title;
    bool completed;
}

contract StructTest {
    struct Todo {
        string text;
        bool completed;
    }

    Todo[] public todos;

    struct Student {
        string name;
        uint grade;
        bool pass;
    }

    Student[] public students;

    function set(string calldata _name, uint _grade, bool _pass) public {
        // THREE WAY to add student
        // 1.
        students.push(Student(_name, _grade, _pass));
        // 2.
        students.push(Student({name: _name, grade: _grade, pass: _pass}));
        // 3. memory
        Student memory myStudent;
        myStudent.name = _name;
        myStudent.grade = _grade;
        myStudent.pass = _pass;
        students.push(myStudent);
    }

    function get(
        uint _index
    ) public view returns (string memory name, uint grade, bool pass) {
        return (
            students[_index].name,
            students[_index].grade,
            students[_index].pass
        );
    }

    function setName(uint _index, string calldata _name) public {
        // in memory
        Student storage newStudent = students[_index];
        newStudent.name = _name;
    }
}
