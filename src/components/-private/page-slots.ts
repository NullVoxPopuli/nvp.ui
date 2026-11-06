/**
 * The page numbers to show as links.
 *
 * `count` consecutive pages around the current one,
 * clamped to the collection.
 *
 * The window slides as the current page changes.
 * Its size does not, so the links never move.
 *
 *   pageSlots(1, 20, 5)  → [1, 2, 3, 4, 5]
 *   pageSlots(10, 20, 5) → [8, 9, 10, 11, 12]
 *   pageSlots(20, 20, 5) → [16, 17, 18, 19, 20]
 *   pageSlots(2, 2, 5)   → [1, 2]
 */
export function pageSlots(page: number, totalPages: number, count: number): number[] {
  if (totalPages < 1) return [];

  const size = Math.min(count, totalPages);
  const first = Math.max(1, Math.min(page - Math.floor(size / 2), totalPages - size + 1));
  const slots: number[] = [];

  for (let i = 0; i < size; i++) {
    slots.push(first + i);
  }

  return slots;
}
