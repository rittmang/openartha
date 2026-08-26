export function StatusPill({ children, tone = 'review' }: { children: React.ReactNode; tone?: 'review' | 'stable' }) {
  return <span className={`status-pill status-${tone}`}>{children}</span>;
}
