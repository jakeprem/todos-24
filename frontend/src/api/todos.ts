import axios from "axios";

const API_URL = "http://localhost:4000/api";

export interface List {
  id: number;
  name: string;
  createdAt: string;
  updatedAt: string;
}

export interface Item {
  id: number;
  description: string;
  done: boolean;
  listId: number;
  createdAt: string;
  updatedAt: string;
}

export const getLists = async (): Promise<List[]> => {
  const response = await axios.get(`${API_URL}/lists`);
  return response.data.data;
};

export const createList = async (name: string): Promise<List> => {
  const response = await axios.post(`${API_URL}/lists`, { list: { name } });
  return response.data.data;
};

export const getItems = async (listId: number): Promise<Item[]> => {
  const response = await axios.get(`${API_URL}/lists/${listId}/items`);
  return response.data.data;
};

export const createItem = async (
  listId: number,
  description: string
): Promise<Item> => {
  const response = await axios.post(`${API_URL}/lists/${listId}/items`, {
    item: { description },
  });
  return response.data.data;
};

export const updateItem = async (
  listId: number,
  itemId: number,
  done: boolean
): Promise<Item> => {
  const response = await axios.put(
    `${API_URL}/lists/${listId}/items/${itemId}`,
    { item: { done } }
  );
  return response.data.data;
};

export const deleteItem = async (
  listId: number,
  itemId: number
): Promise<void> => {
  await axios.delete(`${API_URL}/lists/${listId}/items/${itemId}`);
};
