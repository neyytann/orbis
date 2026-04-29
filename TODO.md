# Auto-refresh Interns Profile List (1s with mounted/error handling)

## Plan Summary
Add Timer.periodic(1s) in frontend/lib/pages/interns_list.dart to auto-fetch /interns API, check mounted, handle errors.

## Steps:
1. [x] Add 'dart:async' import
2. [x] Add Timer field in _InternsListState
3. [x] Add _startAutoRefresh() method
4. [x] Call _startAutoRefresh() in initState()
5. [x] Add dispose() to cancel timer
6. [x] Enhance fetchInterns() error handling
7. [ ] Test auto-refresh

Current progress: Edits complete. Ready for testing.

