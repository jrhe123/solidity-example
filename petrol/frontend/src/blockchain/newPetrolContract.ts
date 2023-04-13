import Web3 from "web3";
import { AbiItem } from "web3-utils";
// ABI: remix complier
import ABI from "../ABI.json";
// Contract address: remix deploy & run transaction
const PETROL_ADDRESS = "0xfed04C06Ea829230781Aa907C4cBFd4B641D1B9E";

const newPetrolContract = (web3: Web3) => {
  return new web3.eth.Contract(ABI as unknown as AbiItem, PETROL_ADDRESS);
};

export default newPetrolContract;
