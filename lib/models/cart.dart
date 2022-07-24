import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Cart extends StateNotifier<Map<int, int>> {
    Cart(): super(<int, int>{});

    void add(int productId) {
      // 変更を検知するため、作成し直し
      state = {
          ...state,
      };
      if (state.containsKey(productId)){
        state[productId] = state[productId]! + 1;
      }else{
        state[productId] = 1;
      }
    }

    void remove(int productId) {
      // 変更を検知するため、作成し直し
      state = {
          ...state,
      };
      if (state.containsKey(productId)){
        state[productId] = state[productId]! - 1;
      }else{
        state[productId] = 0;
      }
    }
}
