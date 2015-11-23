{
  if(alive (_x select 0)) then
  {
    (_x select 0) setVariable [(_x select 1), (_x select 0) addAction (_x select 2)];
  };
  false
}count Mission_var_DynamicActions;
