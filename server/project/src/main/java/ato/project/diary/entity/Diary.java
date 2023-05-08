package ato.project.diary.entity;

import ato.project.member.entity.Member;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.util.Date;

@Entity
@Data
@NoArgsConstructor
public class Diary {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long diaryNo;

    @Column(nullable = false)
    private String title;

    @Column(nullable = false)
    private String content;

    @Column(nullable = false)
    private String date;

    @CreationTimestamp
    private Date createDate;

    @UpdateTimestamp
    private Date UpDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;
}
