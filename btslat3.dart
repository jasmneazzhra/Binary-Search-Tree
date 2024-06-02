import 'Praktik10Binary.dart';

class STNode<T> {
  T nodeValue;
  STNode<T>? left, right, parent;

  STNode(this.nodeValue, [this.parent]) {
    left = null;
    right = null;
  }

  STNode.withChildren(this.nodeValue, this.left, this.right) {
    parent = null;
  }
}

class BinarySearchTree<T extends Comparable<dynamic>> {
  STNode<T>? root;
  int treeSize = 0;

  BinarySearchTree() {
    root = null;
  }

  bool add(T item) {
    STNode<T>? t = root, parent;
    int orderValue = 0;

    while (t != null) {
      parent = t;
      orderValue = item.compareTo(t.nodeValue);

      if (orderValue == 0) {
        return false;
      } else if (orderValue < 0) {
        t = t.left;
      } else {
        t = t.right;
      }
    }
    STNode<T> newNode = STNode(item, parent);
    if (parent == null) {
      root = newNode;
    } else if (orderValue < 0) {
      parent.left = newNode;
    } else {
      parent.right = newNode;
    }
    treeSize++;
    return true;
  }

  STNode<T>? findNode(T item) {
    STNode<T>? t = root;
    int orderValue = 0;

    while (t != null) {
      orderValue = item.compareTo(t.nodeValue);

      if (orderValue == 0) {
        return t;
      } else if (orderValue < 0) {
        t = t.left;
      } else {
        t = t.right;
      }
    }
    return null;
  }

  bool find(T item) {
    STNode<T>? t = findNode(item);

    if (t != null) {
      T value = t.nodeValue;
      return true;
    }
    return false;
  }

  STNode<T>? getRoot() {
    return root;
  }

  void removeNode(STNode<T>? dNode) {
    if (dNode == null) {
      return;
    }
    STNode<T>? pNode, rNode;
    pNode = dNode.parent;
    // Node yang dihapus mempunyai satu anak
    if (dNode.left == null || dNode.right == null) {
      if (dNode.right == null) {
        rNode = dNode.left;
      } else {
        rNode = dNode.right;
      }
      if (rNode != null) {
        rNode.parent = pNode;
      }
      // Menghapus node root
      if (pNode == null) {
        root = rNode;
      } else if ((dNode.nodeValue as Comparable<T>).compareTo(pNode.nodeValue) < 0) {
        pNode.left = rNode;
      } else {
        pNode.right = rNode;
      }
    } // Node yang dihapus mempunyai dua anak
    else {
      STNode<T>? pOfRNode = dNode;
      rNode = dNode.right;
      pOfRNode = dNode;
      while (rNode!.left != null) {
        pOfRNode = rNode;
        rNode = rNode.left;
      }
      dNode.nodeValue = rNode.nodeValue;
      if (pOfRNode == dNode) {
        dNode.right = rNode.right;
      } else {
        pOfRNode?.left = rNode.right;
      }
      if (rNode.right != null) {
        rNode.right!.parent = pOfRNode;
      }
    }
    treeSize--;
  }

  static void InOrderDisplay<T>(STNode<T>? node) {
    if (node != null) {
      InOrderDisplay(node.left);
      print(node.nodeValue);
      InOrderDisplay(node.right);
    }
  }

  static void PostOrderDisplay<T>(STNode<T>? node) {
    if (node != null) {
      PostOrderDisplay(node.left);
      PostOrderDisplay(node.right);
      print(node.nodeValue);
    }
  }

  T? first() {
    STNode<T>? current = root;

    if (current == null) {
      return null;
    }

    while (current!.left != null) {
      current = current.left;
    }

    return current.nodeValue;
  }

  T? last() {
    STNode<T>? current = root;

    if (current == null) {
      return null;
    }

    while (current!.right != null) {
      current = current.right;
    }

    return current.nodeValue;
  }

  void addNewNode(T item) {
    add(item);
  }
}

void main() {
  BinarySearchTree<dynamic> bst = BinarySearchTree();
  bst.add(10);
  bst.add(5);
  bst.add(20);
  bst.add(2);
  bst.add(6);
  bst.add(19);
  bst.add(25);
  bst.add(21);
  print('Tree Size: ${bst.treeSize}');

  print('PostOrder Traversal:');
  BinarySearchTree.PostOrderDisplay(bst.getRoot());

  var nodeFound = bst.findNode(19);
  if (nodeFound != null) {
    print('Node with value 19 found.');
  } else {
    print('Node with value 19 not found.');
  }

  nodeFound = bst.findNode(55);
  if (nodeFound != null) {
    print('Node with value 55 found.');
  } else {
    print('Node with value 55 not found.');
  }

  bst.addNewNode(56);
  print('New node with value 56 added.');

  print('Binary Search Tree setelah node 56 ditambahkan:');
  BinarySearchTree.InOrderDisplay(bst.getRoot());


  var smallestValue = bst.first();
  if (smallestValue != null) {
    print('The smallest value in the tree is: $smallestValue');
  } else {
    print('The tree is empty.');
  }

  var largestValue = bst.last();
  if (largestValue != null) {
    print('The largest value in the tree is: $largestValue');
  } else {
    print('The tree is empty.');
  }
}
