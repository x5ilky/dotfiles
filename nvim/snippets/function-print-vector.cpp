template <typename T>
void print_vector(vector<T>& vec) {
    bool first = true;
    for (auto& a : vec) {
        if (first) cout << a;
        else cout << " " << a;
    }
    cout << endl;
}
