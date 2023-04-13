// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract EnumTest {
    // 0,1,2,3,4
    enum Status {
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }

    // default 0
    Status public status;

    function get() public view returns (Status) {
        return status;
    }

    function set(Status _status) public {
        status = _status;
    }

    function canel() public {
        status = Status.Canceled;
    }

    function reset() public {
        delete status;
    }
}
