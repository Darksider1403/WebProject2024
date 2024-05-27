package DAO;

public interface IDAO<T>{
    int insert(T model);
    int update(T model);
    int delete(T model);
}
